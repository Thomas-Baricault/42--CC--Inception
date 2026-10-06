FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y php-fpm php-mysql curl

COPY ./setup.sh /setup.sh

RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
