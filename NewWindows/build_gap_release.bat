SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

IF EXIST "c:\Program Files (x86)\Inno Setup 6\Compil32.exe" (
  ECHO Inno Setup 6 Found
) ELSE (
  ECHO "c:\Program Files (x86)\Inno Setup 6\Compil32.exe" not Found
  EXIT /B 0
)

call cygwin_install.bat
call run_script_in_cygwin.bat shell_scripts\get_gap_release.sh
call run_script_in_cygwin.bat shell_scripts\apply_gap_patches_for_cygwin.sh
call run_script_in_cygwin.bat shell_scripts\build_gap_and_packages.sh
call move_gap_to_release.bat
call build_installer.bat

ENDLOCAL