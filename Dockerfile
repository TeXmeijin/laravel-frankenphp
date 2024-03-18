FROM dunglas/frankenphp
WORKDIR /app

RUN install-php-extensions \
    pcntl
RUN docker-php-ext-install exif pdo_mysql mysqli \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

COPY . /app/
RUN composer install --optimize-autoloader --no-progress

# ENTRYPOINT ["ls", "-al", "/app"]

ENTRYPOINT ["php", "artisan", "octane:frankenphp", "--port", "8088"]
