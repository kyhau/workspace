#!/bin/bash

#echo "Folder size: $(du -sh)" .

declare -a FOLDERS=(
  "build"
  "dist"
  "env"
  "env_*"
  ".cache"
  ".pytest_cache"
  ".tox"
  "*.egg-info"
  "__pycache__"
)
declare -a FILES=(
  ".coverage"
  "coverage*.xml"
  "flake8.log"
  "junit-py*.xml"
  "pylint.log"
  "gurobi.log"
  "pyinstaller_out.log"
)

delete_stuff() {
  local option=${1}
  shift
  local targets=("$@")
  for target in "${targets[@]}"
  do
    echo "Finding $target in current directory"
    for item in $(find -name "${target}" -type ${option})
    do
      echo "Removing ${item}"
      rm -rf ${item}
    done
  done
}

delete_stuff "d" "${FOLDERS[@]}"
delete_stuff "f" "${FILES[@]}"

#echo "Folder size: $(du -sh)" .
