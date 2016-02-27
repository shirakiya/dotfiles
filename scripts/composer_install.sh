#/bin/bash

set -e

# install composer
curl -sS https://getcomposer.org/installer | php
cp composer.phar /usr/local/bin/composer

# install phpunit via composer
composer global require "phpunit/phpunit=4.8.*"
