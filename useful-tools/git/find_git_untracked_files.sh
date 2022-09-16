#!/bin/bash

for D in *; do
  if [ -d "${D}" ]; then
    echo "--------------------------------------------------------------------------------"
    echo "Checking ${D}/"
    cd ${D}

    git ls-files --others --exclude-standard

    cd ..
  fi
done
