FROM php:8.5.3-fpm
WORKDIR /var/www/html
RUN apt-get update -y \
    && apt-get install -y --quiet --no-install-recommends \
    libzip-dev \
    unzip \
    libicu-dev \
    && docker-php-ext-install \
    zip \
    pdo \
    pdo_mysql \
    intl \
    && pecl install -o -f redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.9.5 /usr/bin/composer /usr/bin/composer

RUN composer require predis/predis

RUN groupadd --gid 1000 appuser \
    && useradd --uid 1000 -g appuser \
    -G www-data,root --shell /bin/bash \
    --create-home appuser

USER appuser
