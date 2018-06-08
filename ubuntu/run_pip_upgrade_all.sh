#!/bin/bash

pip install -U pip
pip freeze > requirements_27.txt && pip install --upgrade -r requirements_27.txt && pip freeze > requirements_27.txt

pip3 install -U pip
pip3 freeze > requirements_36.txt && pip3 install --upgrade -r requirements_36.txt && pip3 freeze > requirements_36.txt
