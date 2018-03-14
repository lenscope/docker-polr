#!/bin/sh

cd /src
if [ ! -f ".env" ]; then
    POLR_GENERATED_AT=`date +"%B %d, %Y"`
    export POLR_GENERATED_AT

    envsubst < ".env_polr" > ".env"

    php artisan key:generate
    php artisan migrate:install
    php artisan migrate
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
