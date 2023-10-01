FROM php:8.2.11-cli-bullseye
LABEL authors="riandyrn"

WORKDIR /s3-private-url-php

COPY . .

ENTRYPOINT ["php", "-S", "0.0.0.0:9180", "-t", "/s3-private-url-php/src/"]