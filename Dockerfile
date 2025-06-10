FROM php:8.3-alpine AS depart

COPY certificats/*.crt /usr/local/share/ca-certificates/

RUN apk --no-cache --no-check-certificate add ca-certificates \
    && update-ca-certificates

# Installer les extensions PHP nécessaires
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    libzip-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd zip mysqli pdo pdo_mysql

# Créer le répertoire web et définir les permissions
RUN mkdir -p /var/www/html

# Copier composer.json et composer.lock (si présent)
COPY ./src /var/www/html/

# Changer vers le répertoire de travail
WORKDIR /var/www/html

FROM nginx:1.28.0-alpine-slim AS fin-finale

COPY certificats/*.crt /usr/local/share/ca-certificates/

RUN apk --no-cache --no-check-certificate \
    add ca-certificates \
    && update-ca-certificates

# Installer les dépendances pour les extensions PHP
RUN apk add --no-cache \
    php83-dev \
    gcc \
    musl-dev \
    make \
    autoconf

# Installer PHP-FPM, MySQL/MariaDB et Supervisor
RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-pdo_mysql \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-zlib \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-xmlreader \
    php83-ctype \
    php83-session \
    php83-mbstring \
    phpmyadmin \
    mariadb \
    mariadb-client \
    supervisor

# Crée /var/www/html pour aller mettre ce qui a été créé dans le dernier stage ici
RUN mkdir -p /var/www/html
COPY --from=depart /var/www/html /var/www/html
COPY --from=depart /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=depart /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Créer les répertoires pour MySQL et les scripts
RUN mkdir -p /var/lib/mysql /run/mysqld /scripts /var/log/mysql
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

# Configurer PhpMyAdmin
RUN ln -s /usr/share/webapps/phpmyadmin /var/www/html/phpmyadmin

# Copier le script d'initialisation de la base de données
COPY scripts/init-db.sql /scripts/
COPY scripts/init-db.sh /scripts/
COPY conf/my.cnf /etc/mysql/my.cnf
RUN chmod +x /scripts/init-db.sh

# Copier les configurations Nginx, MySQL et Supervisor
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/supervisord.conf /etc/supervisord.conf
COPY conf/config.inc.php /etc/phpmyadmin/config.inc.php

# Définir les permissions appropriées
RUN chown -R nginx:nginx /var/www/html

# Créer un volume pour la persistance de la base de données
VOLUME ["/var/lib/mysql"]

# Exposer le port 12080 (Nginx) et 3306 (MySQL)
EXPOSE 12080 3306

# Démarrer Supervisor qui gérera Nginx et PHP-FPS
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]