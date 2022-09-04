#!/bin/bash

#echo "Folder size: $(du -sh)" .

declare -a FOLDERS=(
  "build"
  "dist"
  "cdk.out"
  "env"
  "env_*"
  "node_modules"
  "wheelmaker"
  ".cache"
  ".mypy_cache"
  ".pytest_cache"
  ".tox"
  "*.egg-info"
  "__pycache__"
)
declare -a FILES=(
  ".coverage*"
  "cdk.context.json"
  "coverage*.xml"
  "flake8.log"
  "junit-py*.xml"
  "gurobi.log"
  "pyinstaller_out.log"
  "pylint.log"
  "yarn-error.log"
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
