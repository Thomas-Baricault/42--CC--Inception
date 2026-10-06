#!/bin/bash

sed -i \
  -e "s/^bind-address[ \t].*/bind-address = 0.0.0.0/" \
  -e "s/^user[ \t].*/user = ${MYSQL_ROOT_NAME}/" \
  /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start

mysql \
    -u root \
    -e "
        ALTER USER '${MYSQL_ROOT_NAME}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER_NAME}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER_NAME}'@'%';
        FLUSH PRIVILEGES;
    "

mysqladmin -u "${MYSQL_ROOT_NAME}" -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe
