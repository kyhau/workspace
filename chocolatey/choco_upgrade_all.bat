@ECHO OFF

ECHO Started: %DATE:~10,4%-%DATE:~7,2%-%DATE:~4,2%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%

::ECHO Checking outdated packages ...
::CALL choco outdated

ECHO Upgrading packages ...
CALL choco upgrade -y all

EXIT /B 0
