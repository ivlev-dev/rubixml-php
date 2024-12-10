FROM php:8.2.26-alpine

RUN docker-php-ext-enable opcache

RUN apk --no-cache add linux-headers zlib-dev libpng-dev oniguruma-dev && \
    docker-php-ext-install gd mbstring && \
    apk del linux-headers zlib-dev libpng-dev oniguruma-dev

RUN apk --no-cache add $PHPIZE_DEPS openblas-dev && \
    pecl install tensor && \
    docker-php-ext-enable tensor && \
    apk del $PHPIZE_DEPS openblas-dev

COPY --from=composer:2.8.3 /usr/bin/composer /usr/local/bin/composer
