#!/bin/bash

pip3.7 install -U pip
pip3.7 freeze > requirements_37s.txt && pip3.7 install --upgrade -r requirements_37.txt && pip3.7 freeze > requirements_37.txt
