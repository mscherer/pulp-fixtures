#!/usr/bin/env bash

set -ex

if [[ ! -f /usr/share/nginx/html/base_url_fixed ]] && [[ -n "$BASE_URL" ]]; then

    STRIPPED_URL=${BASE_URL%/}

    # inject BASE_URL at runtime
    find /usr/share/nginx/html \( -name "*mirrorlist*" -o -name "*.html" -o -name "*.json" \) \
      -exec sed -i -e "s%http://BASE_URL%$STRIPPED_URL%g" {} +

    touch /usr/share/nginx/html/base_url_fixed

fi

if [[ -z "$NO_NGINX" ]]; then
    nginx -g 'daemon off;'
fi;
