FROM php:8.2.26-alpine

RUN docker-php-ext-enable opcache

RUN apk --no-cache add $PHPIZE_DEPS openblas openblas-dev lapack-dev && \
    pecl install tensor && \
    docker-php-ext-enable --ini-name zz-tensor.ini tensor.so && \
    apk del $PHPIZE_DEPS lapack-dev openblas-dev

COPY --from=composer:2.8.3 /usr/bin/composer /usr/local/bin/composer