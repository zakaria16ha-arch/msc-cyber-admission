#!/bin/sh
set -e
if [ ! -f /var/www/html/wp-includes/version.php ]; then
  cp -r /usr/src/wordpress/. /var/www/html/
  chown -R www-data:www-data /var/www/html
fi
exec "$@"
