#!/bin/bash
set -e

if [[ -z "$1" ]]; then
  echo "Missing branch name"
else
  git branch $1
  git checkout $1
fi
