# OpenID Configuration URI https://token.actions.githubusercontent.com/.well-known/openid-configuration
# Json Web Key Service URI https://token.actions.githubusercontent.com/.well-known/jwks

PROVIDER_URL="token.actions.githubusercontent.com"

echo | openssl s_client -servername ${PROVIDER_URL} -showcerts -connect ${PROVIDER_URL}:443 2> /dev/null \
| sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sed "0,/-END CERTIFICATE-/d" \
| openssl x509 -fingerprint -noout | cut -f2 -d'=' | tr -d ':' | tr '[:upper:]' '[:lower:]'
