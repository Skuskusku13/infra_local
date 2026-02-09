FROM alpine:3.21 AS development

RUN apk update && apk upgrade
RUN apk add --no-cache gzip logrotate tzdata

ENV LOG_LOGROTATE=/var/log/docker-services/logrotate
ENV TZ=Europe/Paris

COPY ./logrotate-conf_dev /etc/logrotate.d/logrotate-conf

RUN echo "${TZ}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

# Créer un fichier cron pour logrotate
RUN echo "0 10,15 * * * /usr/sbin/logrotate -v /etc/logrotate.conf > ${LOG_LOGROTATE}/logrotate.log 2>&1" >> /etc/crontabs/root


CMD ["crond", "-f", "-l", "2"]


FROM alpine:3.21 AS production

RUN apk update && apk upgrade
RUN apk add --no-cache gzip logrotate tzdata

ENV LOG_LOGROTATE=/var/log/docker-services/logrotate
ENV TZ=Europe/Paris

COPY ./logrotate-conf /etc/logrotate.d/logrotate-conf

RUN echo "${TZ}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

# Créer un fichier cron pour logrotate
RUN echo "0 0 * * * /usr/sbin/logrotate -v /etc/logrotate.conf > ${LOG_LOGROTATE}/logrotate.log 2>&1" >> /etc/crontabs/root


CMD ["crond", "-f", "-l", "2"]