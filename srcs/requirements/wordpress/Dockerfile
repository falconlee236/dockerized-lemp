FROM debian:bullseye


RUN apt-get -y -qq update
RUN apt-get -y -qq upgrade
RUN apt-get -y -qq install wget curl php7.4 php-cli php-fpm php-mysql mariadb-client tini
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get -y -qq update 
RUN apt-get -y -qq install php7.4-curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x ./wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp 
RUN wp cli update
RUN mkdir -p /run/php/

RUN sed -i 's/\/run\/php\/php7.4-fpm.sock/0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh /
RUN chmod +x ./entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]