#!/bin/bash

pip install -U pip
pip freeze > tmp_requirements.txt && pip install -U -r tmp_requirements.txt && rm tmp_requirements.txt
