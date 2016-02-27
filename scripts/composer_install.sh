#/bin/bash

set -e

# install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install phpunit via composer
composer global require "phpunit/phpunit=4.8.*"
