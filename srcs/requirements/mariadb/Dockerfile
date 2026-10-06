FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server

COPY ./setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]
