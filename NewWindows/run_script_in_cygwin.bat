SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

set arg1=%1
shift

copy /Y %arg1% cygwin_build_gap\script.sh

REM -- Jump into cygwin
REM -- Based on Cygwin.bat
setlocal enableextensions
set TERM=
cd /d cygwin_build_gap\bin && .\bash --login /script.sh



ENDLOCAL

EXIT /B 0
