SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0


rmdir /S /Q cygwin_release_gap\opt\gap
xcopy /E /Y /Q /C cygwin_build_gap\opt\gap cygwin_release_gap\opt\gap\

REM -- copy custom cygwin files
xcopy /E /Y /Q /C extra_cygwin_files\* cygwin_release_gap

REM -- copy cygstart to start, as various GAP packages use 'start'
REM -- to start external programs (as this is the command used to start commands
REM -- in the windows shell).
copy /Y cygwin_release_gap\bin\cygstart.exe cygwin_release_gap\bin\start.exe

REM - Clean up git repository (if present)
rmdir /S /Q cygwin_release_gap\opt\gap\.git

REM - Clean up package archive (if downloaded)
del /Q cygwin_release_gap\opt\gap\*.tar.gz

REM - Clean up any build script left lying around
del /S /Q cygwin_release_gap\script.sh

ENDLOCAL
