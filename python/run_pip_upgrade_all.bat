@ECHO OFF

CALL c:\python27\python.exe -m pip install -U pip
CALL pip2 freeze > requirements_win_27.txt && pip2 install --upgrade -r requirements_win_27.txt && pip2 freeze > requirements_win_27.txt

CALL c:\python37\python.exe -m pip install -U pip
CALL pip3 freeze > requirements_win_37.txt && pip3 install --upgrade -r requirements_win_37.txt && pip3 freeze > requirements_win_37.txt
