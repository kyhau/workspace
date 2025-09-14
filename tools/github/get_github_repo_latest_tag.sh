#!/bin/bash
# Ref: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
set -e

if [ -z "$1" ]; then
  echo "Usage: REPO_NAME (e.g. kyhau/ssllabs-scan)"
else
  curl --silent "https://api.github.com/repos/$1/tags" | grep -Po '"name": "\K.*?(?=")' | head -n 1
fi
