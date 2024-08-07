#!/bin/sh

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	service mariadb start
	sleep 2

	mysql -uroot -p$MARIADB_ROOT_PWD -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PWD';"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$WP_DB_USER'@'%' WITH GRANT OPTION;"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';"
	mysql -uroot -p$MARIADB_ROOT_PWD -e "FLUSH PRIVILEGES;"

	mysqladmin -uroot -p$MARIADB_ROOT_PWD shutdown
fi

exec mysqld_safe