#!/bin/bash

rm *.json

./getTCTokens.sh

TC_ACCESS_TOKEN=`awk -F\" {'print $4'} tmpTCTokens.json`
TC_REFRESH_TOKEN=`awk -F\" {'print $8'} tmpTCTokens.json`

printf "\nTC_ACCESS_TOKEN=${TC_ACCESS_TOKEN} \n"
printf "\nTC_REFRESH_TOKEN=${TC_REFRESH_TOKEN} \n\n"

./getYOTokens.sh

YO_ACCESS_TOKEN=`awk -F\" {'print $4'} tmpYOTokens.json`
YO_REFRESH_TOKEN=`awk -F\" {'print $8'} tmpYOTokens.json`

printf "\nYO_ACCESS_TOKEN=${YO_ACCESS_TOKEN} \n"
printf "\nYO_REFRESH_TOKEN=${YO_REFRESH_TOKEN} \n\n"

#Get Current Epoch Time
EPOCH_TIME=`date +%s`

#Create Charter Account
printf "Creating 3rd party account...\n"
curl -s -X POST \
  https://api.staging.yonomi.co/devices \
  -H 'Authorization: Bearer '${YO_ACCESS_TOKEN} \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{ 
    "name": "3rd party Account",
    "type": "3rd_party_account",
    "expires_in": "86400000",
    "is_authorized": true,
    "credentials": {
    	"expires_in": 86400000,
    	"connected": true,
    	"last_updated": '${EPOCH_TIME}',
    	"token": "'${TC_ACCESS_TOKEN}'",
    	"refresh_token": "'${TC_REFRESH_TOKEN}'"
    }
}'>accountCreate.json

printf "\nAccount Created - output stored in accountCreate.json\n"

ACCOUNT_ID=`awk -F\" {'print $46'} accountCreate.json`

printf "\nSyncing Devices...\n"

#Sync Account to Refresh Devices
curl -s -X POST \
  https://api.staging.yonomi.co/devices/${ACCOUNT_ID}/sync \
  -H 'Authorization: Bearer '${YO_ACCESS_TOKEN} \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' > deviceSync.json

printf "\nDone Syncing Devices - output stored in deviceSync.json\n"

