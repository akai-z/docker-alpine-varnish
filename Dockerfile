FROM alpine:3.8

LABEL maintainer="Ammar K."

ENV LISTEN_ADDRESS="" \
    LISTEN_PORT=8080 \
    MANAGEMENT_INTERFACE_ADDRESS=localhost \
    MANAGEMENT_INTERFACE_PORT=6082 \
    BACKEND_DEFAULT_HOST=localhost \
    BACKEND_DEFAULT_PORT=8080 \
    VSL_RECLEN=255 \
    MALLOC=256m

COPY config/default.vcl.template /etc/varnish/
COPY docker-entrypoint.sh /usr/local/bin/

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
    && mv /tmp/envsubst /usr/local/bin/ \
    && ln -s usr/local/bin/docker-entrypoint.sh / # backward compatibility

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE $LISTEN_PORT $MANAGEMENT_INTERFACE_PORT
CMD ["varnishd"]
