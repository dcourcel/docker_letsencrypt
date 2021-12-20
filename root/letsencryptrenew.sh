#!/bin/ash
echo Launching certbot
if [ -n "$DRY_RUN" ]; then
    DO_DRY_RUN=--dry-run
else
    DO_DRY_RUN=""
fi
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

certbot certonly $DO_DRY_RUN $AGREE_LICENSE $EMAIL_PARAM --manual --manual-auth-hook=/root/authenticator.sh --manual-cleanup-hook=/root/cleanup.sh --keep-until-expiring $OPTIONS_DOMAINS
