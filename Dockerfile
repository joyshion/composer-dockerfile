FROM alpine:3.8
MAINTAINER Shion <shion.chow@gmail.com>

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk add --no-cache git php7 php7-openssl php7-gd php7-json php7-phar php7-iconv php7-mbstring php7-dom php7-fileinfo php7-tokenizer php7-xml php7-simplexml php7-xmlwriter php7-xmlreader php7-ctype php7-mcrypt php7-pdo php7-pdo_mysql php7-zip\
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'composer.sig');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');unlink('composer.sig');" \
    && composer --version

# Change repository to https://packagist.laravel-china.org
RUN composer config -g repo.packagist composer https://packagist.laravel-china.org

# Set up the volumes and working directory
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]
