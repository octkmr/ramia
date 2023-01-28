FROM php:8.2-apache

# DockerのComposerイメージ内部のcomposer実行ファイルをコピーしている(マルチステージビルド)
# https://qiita.com/yatsbashy/items/02bbbebbfe7e5a5976bc
COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer
COPY default.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update
RUN apt-get install -y \
    unzip \
    zip
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    bcmath

WORKDIR /var/www

RUN echo "Listen 8080" >> /etc/apache2/ports.conf
RUN a2enmod rewrite