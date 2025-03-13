# Use the official PHP image
FROM php:8.1-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql

# Copy FileRun files to the container
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
