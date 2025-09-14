@ECHO OFF

ECHO Changing settings for %USERNAME% ...

SET "CHROME_HISTORY=%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History"
ECHO TASK: Disallowing Chrome to save history (%CHROME_HISTORY%) ...
CALL ATTRIB +R "%CHROME_HISTORY%"
CALL ATTRIB "%CHROME_HISTORY%"
ECHO DONE