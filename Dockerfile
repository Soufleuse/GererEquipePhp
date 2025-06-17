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
    && docker-php-ext-install -j$(nproc) gd zip

# Créer le répertoire web et définir les permissions
RUN mkdir -p /var/www/html

# Copier composer.json et composer.lock (si présent)
COPY ./src /var/www/html/

# Changer vers le répertoire de travail
WORKDIR /var/www/html

# Nouveau stage pour construire l'application .NET
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS dotnet-build

# Installer git pour cloner le repository
RUN apk add --no-cache git

# Cloner le repository
#RUN git clone https://github.com/Soufleuse/ServiceLigueHockeyV2.git /src
RUN git clone https://github.com/Soufleuse/ServiceLigueHockeySqlServer.git /src

WORKDIR /src

# Restore des packages NuGet
RUN dotnet restore

# Build et publish de l'application
RUN dotnet publish -c Release -o /app --no-restore

FROM nginx:1.28.0-alpine-slim AS fin-finale

COPY certificats/*.crt /usr/local/share/ca-certificates/

RUN apk --no-cache --no-check-certificate \
    add ca-certificates \
    && update-ca-certificates

# Installer les dépendances pour les extensions PHP
RUN apk add --no-cache \
    php84-dev \
    gcc \
    musl-dev \
    make \
    autoconf

# Installer PHP-FPM et Supervisor (sans MySQL/MariaDB et extensions MySQL)
RUN apk add --no-cache \
    php84 \
    php84-fpm \
    php84-json \
    php84-openssl \
    php84-curl \
    php84-zlib \
    php84-xml \
    php84-phar \
    php84-intl \
    php84-dom \
    php84-xmlreader \
    php84-ctype \
    php84-session \
    php84-mbstring \
    supervisor

# Installer le runtime .NET et les dépendances pour SQL Server
RUN apk add --no-cache \
    dotnet8-runtime \
    aspnetcore8-runtime \
    krb5-libs \
    libgcc \
    libintl \
    libssl3 \
    libstdc++ \
    zlib

# CONFIGURATION ENVIRONNEMENT Production
# Définir les variables d'environnement pour la Production
ENV ASPNETCORE_ENVIRONMENT=Production
ENV DOTNET_ENVIRONMENT=Production

# Crée /var/www/html pour aller mettre ce qui a été créé dans le stage depart
RUN mkdir -p /var/www/html
COPY --from=depart /var/www/html /var/www/html

# Copier l'application .NET compilée
RUN mkdir -p /app
COPY --from=dotnet-build /app /app

# Copier les configurations Nginx et Supervisor
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY conf/supervisord.conf /etc/supervisord.conf

# Définir les permissions appropriées
RUN chown -R nginx:nginx /var/www/html

# Exposer le port 12080 (Nginx) et le port pour l'API .NET (5245 dans mon cas)
EXPOSE 12080 5245

# Démarrer Supervisor qui gérera Nginx, PHP-FPM et l'application .NET
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]