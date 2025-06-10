#!/bin/sh

# Variables d'environnement pour la configuration MySQL
DB_NAME=${MYSQL_DATABASE:-"LigueHockey"}
DB_USER=${MYSQL_USER:-"lemste"}
DB_PASSWORD=${MYSQL_PASSWORD:-"Misty@00"}
DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"Misty@00"}

# Fonction pour vérifier si MySQL est accessible
wait_for_mysql() {
    echo "Attente que MySQL soit prêt..."
    for i in $(seq 1 30); do
        if mysql --socket=/run/mysqld/mysqld.sock -e "SELECT 1;" >/dev/null 2>&1; then
            echo "MySQL est prêt!"
            return 0
        fi
        echo "Tentative $i/30..."
        sleep 2
    done
    echo "Erreur: MySQL n'a pas démarré dans les temps"
    return 1
}

# Fonction pour vérifier si la base de données existe
database_exists() {
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"$DB_ROOT_PASSWORD" -e "USE \`$DB_NAME\`;" >/dev/null 2>&1
    return $?
}

# Vérifier si MySQL est déjà initialisé
MYSQL_INITIALIZED=false
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Première initialisation de MySQL..."
    
    # Initialiser la base de données MySQL
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Démarrer MySQL temporairement pour la configuration
    mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=mysql &
    MYSQL_PID=$!
    
    # Attendre que MySQL soit prêt
    if ! wait_for_mysql; then
        kill $MYSQL_PID 2>/dev/null
        exit 1
    fi
    
    # Configurer MySQL
    echo "Configuration initiale de MySQL..."
    mysql --socket=/run/mysqld/mysqld.sock -e "
        SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD');
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
        FLUSH PRIVILEGES;
    "
    
    MYSQL_INITIALIZED=true
    
    # Arrêter MySQL temporaire
    kill $MYSQL_PID
    wait $MYSQL_PID
else
    echo "MySQL déjà initialisé, vérification de la base de données..."
    
    # Démarrer MySQL pour vérifier la base de données
    mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=mysql &
    MYSQL_PID=$!
    
    # Attendre que MySQL soit prêt
    if ! wait_for_mysql; then
        kill $MYSQL_PID 2>/dev/null
        exit 1
    fi
fi

# Vérifier si la base de données spécifique existe
if ! database_exists; then
    echo "La base de données '$DB_NAME' n'existe pas. Création en cours..."
    
    # Créer la base de données et l'utilisateur
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"$DB_ROOT_PASSWORD" -e "
        CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
        CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
        GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
        FLUSH PRIVILEGES;
    "
    
    # Exécuter le script SQL d'initialisation s'il existe
    if [ -f "/scripts/init-db.sql" ]; then
        echo "Exécution du script d'initialisation pour la base de données '$DB_NAME'..."
        mysql --socket=/run/mysqld/mysqld.sock -u root -p"$DB_ROOT_PASSWORD" "$DB_NAME" < /scripts/init-db.sql
        echo "Script d'initialisation exécuté avec succès."
    fi
    
    echo "Base de données '$DB_NAME' créée et configurée."
else
    echo "La base de données '$DB_NAME' existe déjà."
fi

# Si MySQL était déjà démarré pour la vérification, l'arrêter
if [ "$MYSQL_INITIALIZED" = "false" ]; then
    kill $MYSQL_PID
    wait $MYSQL_PID
fi

echo "Démarrage de MySQL en mode normal..."
# Démarrer MySQL en mode normal avec la configuration personnalisée
exec mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=mysql