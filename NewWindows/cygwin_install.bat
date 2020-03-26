SETLOCAL
 
REM -- Change to the directory of the executing batch file
CD %~dp0

REM -- Get cygwin
curl https://cygwin.com/setup-x86_64.exe --output setup-x86_64.exe

REM -- Configure paths
SET SITE=http://cygwin.mirrors.pair.com/
SET LOCALDIR=%CD%
SET BUILDROOTDIR=%~dp0\cygwin_build_gap
SET RUNROOTDIR=%~dp0\cygwin_release_gap
ECHO %ROOTDIR%
 
REM -- These are the packages we will install (in addition to the default packages)
SET BUILDPACKAGES=wget,git,gcc,gcc-g++,gcc-core,zlib-devel,m4,make,automake,,libtool,libgmp-devel,libreadline-devel,libncurses-devel,libpopt-devel,libcurl-devel,libidn2-devel,libssl-devel,libssh-devel,openldap-devel,libiconv-devel,libsasl2-devel,libzmq-devel,singular,libboost-devel
SET RUNPACKAGES=libgmp10,libreadline7,zlib0,libncursesw10,libpopt0,libcurl4,libidn2,libssl1.1,libzmq5,singular

REM -- Do it!
ECHO.
ECHO *** SETTING UP BUILD CYGWIN
setup-x86_64 -W --quiet-mode --no-desktop --no-admin --no-startmenu --no-shortcuts  -s %SITE% -l "%LOCALDIR%" -R "%BUILDROOTDIR%" -P %BUILDPACKAGES%

ECHO *** SETTING UP RUNTIME CYGWIN
setup-x86_64 -W --quiet-mode --no-desktop --no-admin --no-startmenu --no-shortcuts  -s %SITE% -l "%LOCALDIR%" -R "%RUNROOTDIR%" -P %RUNPACKAGES%
 
ECHO *** SETUP CYGWINS


ENDLOCAL

EXIT /B 0
