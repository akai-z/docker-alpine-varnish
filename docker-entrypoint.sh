#!/bin/sh

set -eo pipefail

envsubst < /etc/varnish/default.vcl.template > /etc/varnish/default.vcl

varnishd -a $VARNISH_LISTEN_ADDRESS:$VARNISH_LISTEN_PORT \
  -T $VARNISH_MANAGEMENT_LISTEN_ADDRESS:$VARNISH_MANAGEMENT_LISTEN_PORT \
  -Ff /etc/varnish/default.vcl \
  -p feature=+esi_disable_xml_check,+esi_ignore_other_elements \
  -p vsl_reclen=$VSL_RECLEN \
  -p vcc_allow_inline_c=on \
  -p 'cc_command=exec cc -fpic -shared -Wl,-x -o %o %s -lcrypto -lssl' \
  -s malloc,$MALLOC
