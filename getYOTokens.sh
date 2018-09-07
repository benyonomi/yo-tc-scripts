#!/bin/bash

#--------Fill In Your Info Here------------
YO_USERNAME="your_yo_username"
YO_PASSWORD="********"
YO_CLIENT_ID="your_yo_client_id"
#------------------------------------------

printf "Getting Yonomi One Tokens...\n"

#Get YO tokens
curl -s -X POST \
  https://auth.staging.yonomi.co/oauth2/token \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
	"grant_type":"password",
	"username":"'${YO_USERNAME}'",
	"password":"'${YO_PASSWORD}'",
	"client_id":"'${YO_CLIENT_ID}'",
	"client_secret":""
}'>tmpYOTokens.json
