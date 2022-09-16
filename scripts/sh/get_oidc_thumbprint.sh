#!/bin/bash
set -e

[[ ! -z "$1" ]] || { echo "Missing argument: PROVIDER_URL (e.g. token.actions.githubusercontent.com)"; return; }

PROVIDER_URL=${1}

echo INFO: OpenID Configuration URI = https://${PROVIDER_URL}/.well-known/openid-configuration
echo INFO: Json Web Key Service URI = https://${PROVIDER_URL}/.well-known/jwks

# Ref: https://gist.github.com/guitarrapc/8e6b68f21bc1eef8e7b66bde477d5859?permalink_comment_id=4027755#file-_get_github_oidc_thumbprint-sh
# Ref: https://stackoverflow.com/questions/69247498/how-can-i-calculate-the-thumbprint-of-an-openid-connect-server

echo | openssl s_client -servername ${PROVIDER_URL} -showcerts -connect ${PROVIDER_URL}:443 2> /dev/null \
| sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sed "0,/-END CERTIFICATE-/d" \
| openssl x509 -fingerprint -noout | cut -f2 -d'=' | tr -d ':' | tr '[:upper:]' '[:lower:]'
