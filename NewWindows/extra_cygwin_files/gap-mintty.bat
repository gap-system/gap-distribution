@echo off
setlocal enableextensions
set TERM=
cd /d "%~dp0bin" && mintty.exe -s 120,40 .\bash --login /run-gap-mintty.sh
