#!/bin/bash
# wrk - a HTTP benchmarking tool
# https://github.com/wg/wrk
# Install: https://medium.com/@felipedutratine/intelligent-benchmark-with-wrk-163986c1587f

set -e

[[ -e "${HOME}/.local/bin/wrk" ]] && rm ${HOME}/.local/bin/wrk

[[ -d "${HOME}/.local/wrk" ]] && rm -rf ${HOME}/.local/wrk
