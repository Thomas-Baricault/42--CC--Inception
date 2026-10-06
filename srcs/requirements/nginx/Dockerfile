FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx openssl

COPY ./setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 443

ENTRYPOINT ["/setup.sh"]
