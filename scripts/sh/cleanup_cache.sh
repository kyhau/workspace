#!/bin/bash
set -e

declare -a FOLDERS=(
  "${HOME}/.cache/"
  "${HOME}/.tox/"
)

for target in "${FOLDERS[@]}"; do
  if [[ -d ${target} ]]; then
      echo "INFO: Cleaning up ${target}"
      cd $target
      for i in $( ls ); do
        du -sh ${i}
        rm -rf ${i}
      done
      cd -
  fi
done
