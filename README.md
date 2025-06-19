# Construire l'image
docker build --no-cache -t mon-exemple-php .

# Rouler l'image - oui, il y a un user/mot de passe, mais ce sont des données non-nominatives qu'il y a dans la BD.
docker run -p 12080:12080 -p 5245:5245 -d -v C:\Users\lemst5\source\repos\php\GererEquipePHP\mysql_data:/var/lib/mysql -e MYSQL_DATABASE=LigueHockey -e MYSQL_USER=lemste -e MYSQL_PASSWORD=Misty@00 -e MYSQL_ROOT_PASSWORD=Misty@00 --name mon-appllication mon-exemple-php

docker run -p 12080:12080 -p 5245:5245 -d -v C:\Users\lemst5\source\repos\php\GererEquipePHP\mysql_data:/var/lib/mysql --name mon-appllication mon-exemple-php

# Stopper l'appllication
docker stop mon-application

# Détruire l'image
docker rmi mon-exemple-php