# Use the official PHP image
FROM php:8.1-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql

# Set ServerName to suppress Apache warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy FileRun files to the container
COPY ./filerun /var/www/html/

# Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Allow access to the Document Root
RUN echo "<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>" >> /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
