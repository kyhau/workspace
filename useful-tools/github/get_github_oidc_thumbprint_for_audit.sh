#!/bin/bash
set -e

# OpenID Configuration URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/openid-configuration
# Json Web Key Service URI https://oidc-configuration.audit-log.githubusercontent.com/.well-known/jwks

openssl s_client -servername oidc-configuration.audit-log.githubusercontent.com -showcerts -connect oidc-configuration.audit-log.githubusercontent.com:443 < /dev/null 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sed "0,/-END CERTIFICATE-/d" > certificate.crt
openssl x509 -in certificate.crt -fingerprint -noout | cut -f2 -d'=' | tr -d ':' | tr '[:lower:]' '[:upper:]'

rm certificate.crt
