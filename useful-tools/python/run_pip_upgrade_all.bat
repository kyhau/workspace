@ECHO OFF

CALL pip install -U pip --user
CALL pip freeze > tmp_win_requirements.txt
CALL pip install -U -r tmp_win_requirements.txt
DEL tmp_win_requirements.txt
