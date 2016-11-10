FROM php:fpm-alpine

RUN docker-php-ext-install mysqli \
                           sqlite3 \
                           phar \
                           pdo-mysql \
                           pdo-sqlite \
                           gd \
                           zip \
                           jpeg \
                           xcache \
                           apc \
                           xsl \
                           xmlreader \
                           xmlwriter \
                           json \
                           curl \
                           dom

EXPOSE 9000
WORKDIR /var/www/html
