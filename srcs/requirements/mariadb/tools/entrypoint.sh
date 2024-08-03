#!/bin/bash
# bash shell을 사용한다.
# start text
echo start setting mariadb
# check new version of package
apt-get -y -qq update
# upgrade new version of package
apt-get -y -qq upgrade
# package install
apt-get -y -qq install mariadb-server vim

# start mariadb server demon 
# (mariadb는 mysql로 쉽게 변환 할수 있으며, 커멘드를 mysql로 통일함)
# 이거는 왜 안되지...
# service mysql start

# .conf.d 파일에 bind-address줄을 주석처리 한다.(외부 ip에서 접근 허용) -i option은 해당 파일에 변경사항을 적용하는 옵션
sed -i "s/bind-address/#bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf
# debian config 파일에서 root 비밀번호 변경
sed -i "s/password =/password = $MARIADB_ROOT_PWD/g" /etc/mysql/debian.cnf


# localhost로 접속하는 root계정의 비밀변호 변경하기
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PWD}';" | mysql -u root -p $MARIADB_ROOT_PWD
# 새로운 DB 만들기
echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;" | mysql -u root -p $MARIADB_ROOT_PWD
# 새로운 user 만들기 -> %는 모든 ip주소에 접속해도 상관 없음
echo "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';" | mysql -u root -p $MARIADB_ROOT_PWD
echo "CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PWD';" | mysql -u root -p $MARIADB_ROOT_PWD
# 새로운 user에 모든 권한을 주기
echo "GRANT ALL PRIVILEGES ON mysql.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';" | mysql -u root -p $MARIADB_ROOT_PWD
echo "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';" | mysql -u root -p $MARIADB_ROOT_PWD
echo "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PWD';" | mysql -u root -p $MARIADB_ROOT_PWD
# 권한 설정한 것 적용
echo "FLUSH PRIVIEGES;" | mysql -u root -p $MARIADB_ROOT_PWD
# 이것도 안될거 같은데 docker compose에서 사용하는듯
# service mysql stop

echo finish setting mariaDB
exec "$@"