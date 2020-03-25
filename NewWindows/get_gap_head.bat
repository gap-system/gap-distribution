SETLOCAL
 
REM -- Change to the directory of the executing batch file
CD %~dp0

copy /Y scripts\get_gap_head.sh gap_cygwin\

REM -- Jump into cygwin
REM -- Based on Cygwin.bat
setlocal enableextensions
set TERM=
cd /d gap_cygwin/bin && .\bash --login /get_gap_head.sh



ENDLOCAL

EXIT /B 0
