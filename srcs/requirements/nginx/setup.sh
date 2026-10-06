#!/bin/bash

mkdir -p /etc/nginx/ssl

openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=Le Havre/L=Le Havre/O=42/OU=42/CN=${DOMAIN_NAME}/"

echo "
server {
	listen 443 ssl;
	listen [::]:443 ssl;

	server_name ${DOMAIN_NAME};

	ssl_certificate		/etc/nginx/ssl/inception.crt;
	ssl_certificate_key	/etc/nginx/ssl/inception.key;

	ssl_protocols	TLSv1.2 TLSv1.3;

	root /var/www/html;

	index index.php index.html;

	location ~ \.php$ {
		include			fastcgi_params;
		fastcgi_pass	wordpress:9000;
		fastcgi_index	index.php;
		fastcgi_param	SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	}
}
" > /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
