#!/bin/bash

for D in *; do
  if [ -d "${D}" ]; then
    echo "Checking ${D}"
    cd ${D}

    if [ -d ".git" ]; then
      git pull
      git -c diff.mnemonicprefix=false -c core.quotepath=false --no-optional-locks fetch --prune origin
    fi
    cd ..
  fi
done
