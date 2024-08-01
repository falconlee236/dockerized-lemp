FROM debian:bullseye

# 앞으로 .은 /etc/mysql
WORKDIR /etc/mysql
# root로 복사
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

# mysql demon 실행
CMD [ "mysqld" ]