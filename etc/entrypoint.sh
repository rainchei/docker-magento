#!/bin/bash
set -eo pipefail

setenv() {
  MAGENTO_ROOT='/var/www/magento2'
  MAGENTO_USER='gosu www-data:www-data'
  MAGENTO_ENV='/etc/magento2/app/etc/env.php'
  PHPFPM_LOG='/var/log/php7.2-fpm.log'
}

main() {
  setenv

  # TODO: dockerize env.php
  echo "Setting up env.php for magento2."
  ${MAGENTO_USER} cp ${MAGENTO_ENV} ${MAGENTO_ROOT}/app/etc/env.php

  echo "Starting php-fpm."
  exec /usr/sbin/php-fpm7.2 -F

  tail -f ${PHPFPM_LOG}
}

# ===

main
