FROM debian:bullseye

RUN apt-get -y update && \
		apt-get -y upgrade && \
		apt-get -y install nginx openssl tini

RUN	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gun/CN=localhost" \
	-keyout /etc/ssl/private/localhost.dev.key \
	-out etc/ssl/certs/localhost.dev.crt && \
	chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/usr/bin/tini", "--", "nginx", "-g", "daemon off;"]