FROM php:8.1.23-apache-bullseye

# Set environment variables
ENV FR_DB_HOST=db \
    FR_DB_PORT=3306 \
    FR_DB_NAME=filerun \
    FR_DB_USER=filerun \
    FR_DB_PASS=filerun \
    APACHE_RUN_USER=user \
    APACHE_RUN_USER_ID=1000 \
    APACHE_RUN_GROUP=user \
    APACHE_RUN_GROUP_ID=1000 \
    LIBVIPS_VERSION="8.14.4" \
    LIBREOFFICE_VERSION="7.5.5" \
    PHP_VERSION_SHORT="8.1"

# Create necessary directories
RUN mkdir -p /var/log/supervisord /var/run/supervisord

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libcurl4-gnutls-dev \
    libldap2-dev \
    unzip \
    cron \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql gd zip ldap \
    && a2enmod rewrite

# Copy FileRun files
COPY ./filerun /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
