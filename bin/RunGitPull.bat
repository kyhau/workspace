@ECHO OFF

FOR /D %%i IN (.\*) DO (
  PUSHD %%i
  ECHO Checking %%i ...
  IF EXIST .git (
      CALL git pull
      CALL git fetch
  )
  POPD
)
