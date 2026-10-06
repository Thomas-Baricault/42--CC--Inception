#!/bin/bash

mkdir -p /var/www/html

cd /var/www/html

if [ ! -f wp-config.php ]; then

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	wp core download --allow-root

	wp config create \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER_NAME}" \
		--dbpass="${MYSQL_USER_PASSWORD}" \
		--dbhost=mariadb \
		--allow-root

	wp core install \
		--url="${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_NAME}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--allow-root

	wp user create \
		$WP_USER_NAME \
		$WP_USER_EMAIL \
		--user_pass=$WP_USER_PASSWORD \
		--allow-root

fi

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

exec /usr/sbin/php-fpm7.4 -F
