@ECHO OFF

CALL pip install -U pip
CALL pip freeze > requirements_win_27.txt && pip install --upgrade -r requirements_win_27.txt && pip3 freeze > requirements_win_27.txt

CALL pip3 install -U pip
CALL pip3 freeze > requirements_win_36.txt && pip3 install --upgrade -r requirements_win_36.txt && pip3 freeze > requirements_win_36.txt
