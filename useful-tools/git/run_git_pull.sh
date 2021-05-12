#!/bin/bash

run_git_commands() {
  git pull
  git -c diff.mnemonicprefix=false -c core.quotepath=false --no-optional-locks fetch --prune origin
}

if [ -d ".git" ]; then
  run_git_commands
else
  for D in *; do
    if [ -d "${D}" ]; then
      echo "Checking ${D}/"
      cd ${D}

      if [ -d ".git" ]; then
        run_git_commands
      fi
      cd ..
    fi
  done
fi
