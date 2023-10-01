FROM php:8.2.11-cli-bullseye
LABEL authors="riandyrn"

RUN apt-get update && apt-get install -y \
	git \
	unzip \
	libzip-dev \
	&& docker-php-ext-install zip

WORKDIR /s3-private-url-php

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install

COPY src/ ./src/

# this is only for demo purpose, in production you should use nginx or apache
ENTRYPOINT ["php", "-S", "0.0.0.0:9114", "-t", "/s3-private-url-php/src/"]