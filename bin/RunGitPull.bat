for /D %%i in (.\*) do (cd %%i && echo %%i && git pull && cd ..)
