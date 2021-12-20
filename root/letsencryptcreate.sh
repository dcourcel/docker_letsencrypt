#!/bin/ash

if [ -n "$CERTBOT_AGREE" ]; then
    AGREE_LICENSE=--agree-tos
else
    AGREE_LICENSE=""
fi
if [ -z "$EMAIL" ]; then
    EMAIL_PARAM=""
elif [ "$EMAIL" = '-' ]; then
    EMAIL_PARAM=--register-unsafely-without-email
else
    EMAIL_PARAM="--email $EMAIL"
fi

echo Launching certbot
certbot certonly $AGREE_LICENSE $EMAIL_PARAM --standalone --keep-until-expiring $OPTIONS_DOMAINS
