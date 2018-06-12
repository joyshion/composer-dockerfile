FROM php:7.1-alpine
MAINTAINER Shion <shion.chow@gmail.com>

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'composer.sig');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');unlink('composer.sig');"

# Change repository to https://packagist.phpcomposer.com
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

# Display version information.
RUN composer --version

# Set up the volumes and working directory
VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]