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


exec "$@"