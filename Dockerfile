# or any alpine based image
FROM alpine:3.18

ENV TZ="Europe/Zurich"

# update
RUN apk update && apk upgrade

# install tzdata for TZ variable
RUN apk add tzdata

# run cronjobs as root
USER root

# copy scripts
COPY ./*.sh /scripts/
RUN chmod +x /scripts/*.sh

# create crontab entry
RUN echo "*/1 * * * * echo 'Hello World'" >> /var/spool/cron/crontabs/root
RUN echo "*/1 * * * * /scripts/script.sh" >> /var/spool/cron/crontabs/root

# run cron daemon in foreground
CMD crond -f
