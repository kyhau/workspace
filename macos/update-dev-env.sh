#!/bin/bash
set -e

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

################################################################################
echo "INFO: Sourcing ~/.zshrc"
source ~/.zshrc

################################################################################
pip install -U \
  pre-commit \
  virtualenvwrapper
