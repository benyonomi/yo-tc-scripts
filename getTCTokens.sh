#!/bin/bash

#--------Fill In Your Info Here------------
TC_USERNAME="your@email.com"
TC_PASSWORD="********"
TC_CLIENT_ID="your_tc_client_id"
#------------------------------------------

printf "Getting ThinCloud Tokens...\n"

#Get ThinCloud tokens
curl -s -X POST \
  https://api.charter.yonomi.cloud/v1/oauth/tokens \
  -H 'Accept: application/json' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d ' {
        "username": "'${TC_USERNAME}'",
        "password": "'${TC_PASSWORD}'",
        "grant_type": "password",
        "clientId": "'${TC_CLIENT_ID}'"
 }'>tmpTCTokens.json

printf "\nTC_ACCESS_TOKEN=${TC_ACCESS_TOKEN} \n"
printf "\nTC_REFRESH_TOKEN=${TC_REFRESH_TOKEN} \n\n"
