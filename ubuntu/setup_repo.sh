#!/bin/bash
set -e

WORKSPACE_REPO_HOME="$( cd "$( dirname $(dirname "${BASH_SOURCE[0]}" ) )" >/dev/null 2>&1 && pwd )"

echo "================================================================================"
echo "CheckPt: Add .github/dependabot.yml"
mkdir -p .github/
cp $WORKSPACE_REPO_HOME/.github/dependabot.yml .github/dependabot.yml

echo "================================================================================"
echo "CheckPt: Add .github/workflow/dependabot-auto-approve-merge.yml"
mkdir -p .github/workflows/
cp $WORKSPACE_REPO_HOME/.github/workflows/dependabot-auto-approve-merge.yml .github/workflows/dependabot-auto-approve-merge.yml

echo "================================================================================"
echo "CheckPt: Add .github/workflow/secrets-scan.yml"
cp $WORKSPACE_REPO_HOME/.github/workflows/secrets-scan.yml .github/workflows/secrets-scan.yml

echo "================================================================================"
echo "CheckPt: Add .pre-commit-config.yaml"
cp $WORKSPACE_REPO_HOME/.pre-commit-config.yaml .pre-commit-config.yaml

echo "================================================================================"
echo "CheckPt: Run: pre-commit install"
pip install -U pre-commit
pre-commit install
