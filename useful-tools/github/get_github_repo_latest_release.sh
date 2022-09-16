#!/bin/bash
# Ref: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
set -e

if [ -z "$1" ]; then
  echo "Usage: REPO_NAME (e.g. versent/saml2aws)"
else
  curl --silent "https://api.github.com/repos/$1/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'
fi
