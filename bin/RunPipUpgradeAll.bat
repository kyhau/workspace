@ECHO OFF

pip install -U pip
pip freeze > requirements.txt && pip install --upgrade -r requirements.txt && rm requirements.txt

pip3 install -U pip
pip3 freeze > requirements.txt && pip3 install --upgrade -r requirements.txt && rm requirements.txt
