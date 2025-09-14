#!/bin/bash
# See also https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/setting-up-the-codeql-cli
set -e

# Fetch the latest version from the repo
LATEST_VERSION=$(curl -s https://api.github.com/repos/github/codeql-action/releases/latest | grep 'tag_name' | cut -d\" -f4)
PKG_URL=codeql-bundle-${LATEST_VERSION}/codeql-bundle-osx64.tar.gz

if [ -x "$(command -v codeql)" ]; then
  echo "INFO: $(codeql --version)"
else
  echo "INFO: codeql not installed"
fi

echo "INFO: Updating codeql"
curl -fsSL https://github.com/github/codeql-action/releases/download/${PKG_URL} -o codeql-bundle-osx64.tar.gz
tar -xzf codeql-bundle-osx64.tar.gz

if [ -d ~/workspace/bin/codeql ]; then
  rm -rf ~/workspace/bin/codeql
else
  mv codeql-bundle-osx64 ~/workspace/bin/codeql
fi
rm -f codeql-bundle-osx64.tar.gz

echo "INFO: $(codeql --version)"
