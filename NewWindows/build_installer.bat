SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

"c:\Program Files (x86)\Inno Setup 6\Compil32.exe" /cc gap.iss

ENDLOCAL

EXIT /B 0
