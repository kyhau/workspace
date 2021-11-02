#!/bin/bash
set -e

git branch -m master main
git status
git push -u origin main
git push origin --delete master
