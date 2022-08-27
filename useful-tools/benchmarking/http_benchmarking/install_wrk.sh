#!/bin/bash
# wrk - a HTTP benchmarking tool - https://github.com/wg/wrk
# Install: https://medium.com/@felipedutratine/intelligent-benchmark-with-wrk-163986c1587f
set -e

mkdir -p ${HOME}/.local/bin

# sudo apt-get install -y build-essential libssl-dev git

echo "INFO: Get latest source from wg/wrk into ${HOME}/.local/wrk"

[[ -d "${HOME}/.local/wrk" ]] || git clone https://github.com/wg/wrk.git ${HOME}/.local/wrk

cd ${HOME}/.local/wrk
git pull
make
cd -

ln -sfn ${HOME}/.local/wrk/wrk ${HOME}/.local/bin/wrk

echo "INFO: wrk version: $(wrk --version)"
