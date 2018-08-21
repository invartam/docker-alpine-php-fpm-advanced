FROM php:fpm-alpine

RUN apk update \
    && apk add libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev \
        imagemagick-dev g++ autoconf m4 make\
    && docker-php-ext-install mysqli \
                              pdo_mysql \
			      mbstring \
                              gd \
                              zip \
                              xsl \
                              soap \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev \
        imagemagick-dev g++ autoconf m4 make

RUN apk add nginx supervisor libxslt libmcrypt libpng \
    && mkdir /app /logs /run/nginx

COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-l", "/logs/supervisord.log", "-j", "/var/run/supervisord.pid"]
WORKDIR /app

# Folders to mount in rw :
#   - /app
#   - /logs
