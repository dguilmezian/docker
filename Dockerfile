# Establecer la imagen base
FROM php:8.0-fpm

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    nano

# Instalar extensiones PHP requeridas
RUN docker-php-ext-install pdo_mysql gd zip mbstring xml

# Copiar la configuración de PHP personalizada si es necesario
# COPY php.ini /usr/local/etc/php/conf.d/

# Definir el directorio de trabajo
WORKDIR /var/www/html

# Copiar el código de la aplicación
COPY apps/ /var/www/html/

# Copiar el archivo fastcgi-php.conf al directorio de snippets de Nginx
#COPY fastcgi-php.conf /etc/nginx/snippets/

# Establecer permisos si es necesario
# RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 9000 para la comunicación con Nginx
EXPOSE 9000

# Comando por defecto al ejecutar el contenedor
CMD ["php-fpm"]

# Opcional: Agregar comandos de post-instalación si es necesario
# RUN composer install
# RUN php artisan migrate
