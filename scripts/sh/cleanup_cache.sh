#!/bin/bash
set -e

declare -a ITEMS=(
  "${HOME}/.cache/"
  "${HOME}/.cdk/"
  "${HOME}/.ipython/"
  "${HOME}/.kube/cache/"
  "${HOME}/.kube/http-cache/"
  "${HOME}/.npm/"
  "${HOME}/.nuget/packages/"
  "${HOME}/.nuget/plugins/"
  "${HOME}/.nvm/.cache/"
  "${HOME}/.pip-audit-cache/"
  "${HOME}/.python_history"
  "${HOME}/.serverless/"
  "${HOME}/.tox/"
  "${HOME}/.viminfo"
  "${HOME}/.yarn/berry/cache/"
)

for target in "${ITEMS[@]}"; do
  echo "INFO: Checking ${target}"
  if [[ -f ${target} ]]; then
    du -sh ${target}
    rm -f ${target}
    echo "INFO: Removed ${target}"
  elif [[ -d ${target} ]]; then
      cd $target
      for i in $( ls ); do
        du -sh ${i}
        rm -rf ${i}
      done
      rm -rf ${target}
      echo "INFO: Removed ${target}"
      cd - 1> /dev/null
  fi
done
