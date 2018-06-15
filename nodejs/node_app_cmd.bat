@ECHO OFF

IF [%1]==[] ( ECHO Missing argument [ACTION]. & GOTO usage)
SET action=%1

IF /I "%action%"=="BUILD" (
  GOTO build
) ELSE (
  IF /I "%action%"=="CMD" (
    GOTO cmd_list
  ) ELSE (
    IF /I "%action%"=="RM_NPM" (
      GOTO rm_npm
    ) ELSE (
      GOTO usage
    )
  )
)

:: Clean up npm cache
:rm_npm
ECHO --------------------------------------------------------------------------------
ECHO CheckPt: Cleaning up %appdata%\npm*
CALL RD /S /Q "%appdata%\npm"
CALL RD /S /Q "%appdata%\npm-cache"
EXIT /B 0

:: Build
:build
ECHO --------------------------------------------------------------------------------
ECHO CheckPt: npm install
CALL npm install

::ECHO CheckPt: Updating and npm install submodule mapbox-gl-draw
::CALL git submodule init
::CALL git submodule update
::pushd src\mapbox-gl-draw
::SET NODE_ENV=production
::CALL npm install
::popd

EXIT /B 0

:cmd_list
ECHO --------------------------------------------------------------------------------
ECHO To run the app in the development mode. The page will reload if you make edits.
ECHO Open http://localhost:3000 to view it in the browser. In this mode the UI will connect to the staging version.
ECHO $ npm start
ECHO:
ECHO To Launch the test runner in the interactive watch mode.
ECHO $ npm test
ECHO:
ECHO To build the app for production to the build folder.
ECHO $ npm run build
EXIT /B 0

:usage
@ECHO Usage: %0 [build ^| cmd ^| rm_npm]

:eof_failure
ECHO Exit 1
EXIT /B 1