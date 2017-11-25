@ECHO OFF

CALL pip freeze > old_requirements.txt
CALL pip uninstall -r old_requirements.txt

CALL pip install -r base_requirements.txt
