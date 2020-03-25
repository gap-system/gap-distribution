SETLOCAL
 
REM -- Change to the directory of the executing batch file
CD %~dp0

REM -- Get cygwin
curl https://cygwin.com/setup-x86_64.exe --output setup.exe

REM -- Configure paths
SET SITE=http://cygwin.mirrors.pair.com/
SET LOCALDIR=%CD%
SET ROOTDIR=%~dp0\gap_cygwin
ECHO %ROOTDIR%
 
REM -- These are the packages we will install (in addition to the default packages)
SET PACKAGES=wget,git,gcc,gcc-g++,gcc-core,m4,libgmp-devel,make,automake
REM -- These are necessary for apt-cyg install, do not change. Any duplicates will be ignored.
REM -- SET PACKAGES=%PACKAGES%,wget,tar,gawk,bzip2,subversion
 
REM -- Do it!
ECHO.
ECHO *** INSTALLING PACKAGES
setup -W --quiet-mode --no-desktop --no-admin --no-startmenu --no-shortcuts  -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%
 
REM -- Show what we did
ECHO.
ECHO.
ECHO cygwin installation updated
ECHO  - %PACKAGES%
ECHO.


ENDLOCAL

EXIT /B 0
