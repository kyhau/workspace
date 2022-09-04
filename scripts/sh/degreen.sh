#!/bin/bash

find . -type f ! -iname "*.bat" ! -iname "*.exe" ! -iname "*.js" ! -iname "*.ps1" ! -iname "*.sh" ! -iname "*.ts" \
  -not -path "*.aws-sam/*" \
  -not -path "*.build/*" \
  -not -path "*.git/*" \
  -not -path "*.idea/*" \
  -not -path "*.pytest_cache/*" \
  -not -path "*.tox/*" \
  -not -path "*.vscode/*" \
  -not -path "*__pycache__/*" \
  -not -path "*cdk.out/*" \
  -not -path "*dist/*" \
  -not -path "*eggs/*" \
  -not -path "*egg-info/*" \
  -not -path "*node_modules/*" \
  -print0 \
  | xargs -0 chmod -x
