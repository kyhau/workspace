#!/bin/bash

for D in *; do
  if [ -d "${D}" ]; then
    echo "Checking ${D}/"
    cd ${D}

    if [ -d ".git" ]; then
      git checkout -- .
    fi
    cd ..
  fi
done
