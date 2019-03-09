#!/bin/bash

pip2 install -U pip
pip2 freeze > requirements_27.txt && pip2 install --upgrade -r requirements_27.txt && pip2 freeze > requirements_27.txt

pip3.6 install -U pip
pip3.6 freeze > requirements_36.txt && pip3.6 install --upgrade -r requirements_36.txt && pip3.6 freeze > requirements_36.txt
