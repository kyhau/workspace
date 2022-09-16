@ECHO OFF

SET "CHROME_HISTORY=%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\"
ECHO TASK: Deleting Chrome history (%CHROME_HISTORY%) ...
CALL DEL /s /f /q "%CHROME_HISTORY%\History"
CALL DEL /s /f /q "%CHROME_HISTORY%\LOG.old"
CALL DEL /s /f /q "%CHROME_HISTORY%\Visited Links"
ECHO DONE