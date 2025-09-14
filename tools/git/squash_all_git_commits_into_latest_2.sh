#!/bin/bash
# Erase all previous git commits, keep only latest
# https://gist.github.com/cemerson/96442176391b4dd52e86b3b952524db7
set -e

github_url=""

rm -rf .git
git init
git add .
git commit -m "Initial commit"
git remote add origin ${github_url}
git push -u --force origin main
