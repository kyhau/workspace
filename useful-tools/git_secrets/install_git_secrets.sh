#!/bin/bash
# https://github.com/awslabs/git-secrets

set -e

INSTALL_BIN=${HOME}/.local/bin
INSTALL_SRC_FOLDER=${HOME}/.local

mkdir -p ${INSTALL_BIN}/

echo "INFO: Get latest source from awslabs/git-secrets into ${INSTALL_SRC_FOLDER}/git-secrets"

[[ -d "${INSTALL_SRC_FOLDER}/git-secrets" ]] || git clone https://github.com/awslabs/git-secrets.git ${INSTALL_SRC_FOLDER}/git-secrets

cd ${INSTALL_SRC_FOLDER}/git-secrets
git pull
cd -

ln -sfn ${INSTALL_SRC_FOLDER}/git-secrets/git-secrets ${INSTALL_BIN}/git-secrets

# Add a configuration template if you want to add hooks to all repositories you initialize or clone in the future.
echo "INFO: RUN git secrets --register-aws --global"

echo "INFO: To add hooks to all your local repositories"
echo "INFO: RUN git secrets --install -f  ~/.git-templates/git-secrets"
echo "INFO: RUN git config --global init.templateDir ~/.git-templates/git-secrets"
