FROM alpine:latest

ENV VALIDATION_PATH /media/letsencrypt_renew/.well-known/acme-challenge
ENV DRY_RUN=
ENV DOMAINS_LIST=

RUN apk add --no-cache apk-cron certbot
RUN mkfifo -m 0666 /var/log/cron.log
COPY root/ /root/
COPY DockerEntrypoint.sh /DockerEntrypoint.sh
RUN crontab /root/cronLetsencrypt

ENTRYPOINT ["/DockerEntrypoint.sh"]
