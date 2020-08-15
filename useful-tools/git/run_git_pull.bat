@ECHO OFF

FOR /D %%i IN (.\*) DO (
  PUSHD %%i
  ECHO Checking %%i ...
  IF EXIST .git (
      CALL git pull
      CALL git -c diff.mnemonicprefix=false -c core.quotepath=false --no-optional-locks fetch --prune origin
  )
  POPD
)