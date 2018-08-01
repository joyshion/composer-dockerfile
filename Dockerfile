FROM composer:latest

# Change repository to https://packagist.phpcomposer.com
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

# Display version information.
RUN composer --version