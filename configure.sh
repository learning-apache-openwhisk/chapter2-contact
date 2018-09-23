#!/bin/sh
CLOUDANT_USER=${1:?cloudant username}
CLOUDANT_PASS=${2:?cloudant password}
MAILGUN_APIKEY=${3:?mailgun api key}
MAILGUN_SANDBOX=${4:?mailgun sandbox domain}
MAILGUN_RECIPIENT=${5:?mailgun recipient}

echo "CLOUDANT_USER=$CLOUDANT_USER">_config.mk
echo "CLOUDANT_PASS=$CLOUDANT_PASS">>_config.mk
echo "MAILGUN_APIKEY=$MAILGUN_APIKEY">>_config.mk
echo "MAILGUN_SANDBOX=$MAILGUN_SANDBOX">>_config.mk
echo "MAILGUN_RECIPIENT=$MAILGUN_RECIPIENT">>_config.mk
