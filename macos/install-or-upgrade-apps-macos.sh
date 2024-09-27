#!/bin/bash
set -e

app_list=(
  dos2unix
  go
  jq
  nvm
  pyenv
  saml2aws
  readline  # for pyenv
  xz  # for pyenv

  ## git / github related
  # act
  gh

  ## scanner
  # gitleaks
  # osv-scanner
  # snyk-cli
  # trufflehog

  ## docker related
  # dive
  # docker
  # lazydocker

  ## k8s related
  helm
  kubectl
  # k9s
  # kops
  # krew
  # kubectx
  # minikube
  # skaffold
)

cast_app_list=(
  lens
)

# Check if the app is installed and install it if it is not with brew
for app in "${app_list[@]}"; do
  if ! command -v "$app" &> /dev/null; then
    brew install "$app"
  else
    brew upgrade "$app"
  fi
done

# Check if the app is installed and install it if it is not with brew
for app in "${cast_app_list[@]}"; do
  if ! command -v "$app" &> /dev/null; then
    brew install --cask "$app"
  else
    brew upgrade "$app"
  fi
done

################################################################################
# Update Python
PYENV_VERSION="3.12"
echo "INFO: Updating Python $PYENV_VERSION"
echo "INFO: Current Python version: $(python --version)"
pyenv install -f "$PYENV_VERSION"
pyenv global "$PYENV_VERSION"
pyenv rehash
echo "INFO: Python version updated: $PYENV_VERSION"

################################################################################
# Update Node.js
echo "INFO: Updating nvm, node, npm"
source $(brew --prefix nvm)/nvm.sh
echo "INFO: NVM version: $(nvm --version)"
echo "INFO: Node.js version: $(node --version)"
echo "INFO: NPM version: $(npm --version)"
nvm install --lts
nvm install-latest-npm
echo "INFO: NVM version updated: $(nvm --version)"
echo "INFO: Node.js version updated: $(node --version)"
echo "INFO: NPM version updated: $(npm --version)"
