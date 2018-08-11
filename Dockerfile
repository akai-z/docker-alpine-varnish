FROM alpine:latest

LABEL maintainer="Ammar K."

ENV VARNISH_LISTEN_ADDRESS="" \
    VARNISH_LISTEN_PORT=8080 \
    WEB_SERVER_HOST=localhost \
    WEB_SERVER_PORT=8080 \
    VARNISH_ADMIN_LISTEN_ADDRESS=localhost \
    VARNISH_ADMIN_LISTEN_PORT=6082 \
    VSL_RECLEN=255 \
    MALLOC=256m

RUN set -x \
    && apk update \
    && apk add -u --no-cache \
        openssl-dev \
        varnish \
    && apk add --no-cache --virtual .gettext gettext \
    && mv /usr/bin/envsubst /tmp/ \
    && runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' /tmp/envsubst \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-cache --virtual .rundeps $runDeps \
    && apk del .gettext \
    && mv /tmp/envsubst /usr/local/bin/

COPY config/default.vcl.template /etc/varnish/

EXPOSE $VARNISH_LISTEN_PORT

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backward compatibility
ENTRYPOINT ["docker-entrypoint.sh"]
