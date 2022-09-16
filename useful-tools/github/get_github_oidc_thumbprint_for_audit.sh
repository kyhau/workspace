#!/bin/bash
set -e

# OpenID Configuration URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/openid-configuration
# Json Web Key Service URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/jwks

echo Approach 1

openssl s_client -servername oidc-configuration.audit-log.githubusercontent.com -showcerts -connect oidc-configuration.audit-log.githubusercontent.com:443 < /dev/null 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sed "0,/-END CERTIFICATE-/d" > certificate.crt
openssl x509 -in certificate.crt -fingerprint -noout | cut -f2 -d'=' | tr -d ':' | tr '[:upper:]' '[:lower:]'

rm certificate.crt

echo Approach 2
# https://stackoverflow.com/questions/69247498/how-can-i-calculate-the-thumbprint-of-an-openid-connect-server

HOST=$(curl -s https://vsoidc-configuration.audit-log.githubusercontent.com/.well-known/openid-configuration | jq -r '.jwks_uri | split("/")[2]')
echo | openssl s_client -servername $HOST -showcerts -connect $HOST:443 2> /dev/null \
| sed -n -e '/BEGIN/h' -e '/BEGIN/,/END/H' -e '$x' -e '$p' | tail +2 \
| openssl x509 -fingerprint -noout \
| sed -e "s/.*=//" -e "s/://g" \
| tr "ABCDEF" "abcdef"
