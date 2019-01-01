FROM composer:latest

# Change repository to https://packagist.laravel-china.org
RUN composer config -g repo.packagist composer https://packagist.laravel-china.org

# Display version information.
RUN composer --version