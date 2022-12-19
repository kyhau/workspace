#!/bin/bash

pip install -U pip
pip list --outdated --exclude PyGObject | grep -v '^Package ' | grep -v '^\-' | cut -d ' ' -f 1  | xargs -n1 pip install -U

#pip freeze > tmp_requirements.txt && pip install -U -r tmp_requirements.txt && rm tmp_requirements.txt
