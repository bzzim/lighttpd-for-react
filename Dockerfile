FROM alpine:3.19.1

LABEL org.opencontainers.image.title="Lighttpd"
LABEL org.opencontainers.image.authors="RTSP <docker@rtsp.us>"
LABEL org.opencontainers.image.source="https://github.com/rtsp/docker-lighttpd"
LABEL org.opencontainers.image.licenses="Apache-2.0"

ARG LIGHTTPD_VERSION=1.4.73-r0

RUN set -x \
    && apk add --no-cache \
    lighttpd${LIGHTTPD_VERSION:+=}${LIGHTTPD_VERSION} \
    lighttpd-mod_auth${LIGHTTPD_VERSION:+=}${LIGHTTPD_VERSION} \
    && rm -rvf /var/cache/apk/* \
    && rm -rvf /etc/lighttpd/* /etc/logrotate.d/lighttpd /var/log/lighttpd /var/www/localhost \
    && mkdir -vp /var/www/html

COPY files/lighttpd/ /etc/lighttpd/
COPY docker-entrypoint.sh /usr/bin
RUN ["chmod", "+x", "/usr/bin/docker-entrypoint.sh"]

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
