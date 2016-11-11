FROM php:fpm-alpine

RUN apk update \
    && apk add libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev \
    && docker-php-ext-install mysqli \
                              sqlite3 \
                              pdo_mysql \
                              mcrypt \
                              gd \
                              zip \
                              xsl \
    && apk del libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev

RUN apk add nginx supervisor \
    && mkdir /app /logs /run/nginx

#libjpeg-turbo libmcrypt libpng libxslt sqlite-libs libgcrypt libgpg-error

COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
VOLUME ["/app", "/logs"]
CMD ["/usr/bin/supervisord", "-l", "/logs/supervisord.log", "-j", "/var/run/supervisord.pid"]
WORKDIR /app
