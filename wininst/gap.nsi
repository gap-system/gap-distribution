# GAP Installer for Windows
#
# Script written by Alexander Konovalov 
#
# Based on the previous NSIS scripts by A.Konovalov for GAP 4.4, 4.5, 4.6
# 
# Updated to use NSISModern User Interface using example scripts 
# from "NSIS\Examples\Modern UI" of NSIS 2.46 by Joost Verburg
#

#######################################################################
#
# include headers
#
!include "WordFunc.nsh"
!insertmacro WordReplace
!include Sections.nsh

# Include Modern UI

  !include "MUI2.nsh"

#######################################################################
#
# Declaring user variables - 
#
var GAP_VER       # GAP version in format 4.10.2
var RXVT_PATH     # Install path in the form C:\gap-4.10.2
var GAP_BAT       # to write gap.bat file
var GAPRXVT_BAT   # to write gaprxvt.bat file
var GAPCMD_BAT   # to write gapmintty.bat file
var IndependentSectionState
var StartMenuFolder

#######################################################################
#
# User variables and other general settings: adjust them here as needed
# 
Section
StrCpy $GAP_VER "4.10.2"
SectionEnd

#Name and file
Name "GAP 4.10.2"
OutFile "gap-4.10.2.exe"

#Default installation folder
InstallDir "C:\gap-4.10.2"

#######################################################################

# A user without admin privileges should be able to install GAP
RequestExecutionLevel user

# Set compressing method (for test compiling may be commented out)
# and /SOLID can be removed (The best ratio is with /SOLID lzma,
# but it takes several times more to pack it, so we may be happy
# with the default compressor)
# SetCompressor /SOLID lzma
# SetCompressor lzma
# SetCompressor /SOLID zlib
# SetCompressor bzip2

#######################################################################
# Interface Settings

  !define MUI_ABORTWARNING

#######################################################################
# Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "copyright.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\GAP" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

#######################################################################
# Languages

  !insertmacro MUI_LANGUAGE "English"

#######################################################################
#
# Installer Sections
#

#######################################################################
#
# The core GAP system - required component
#
Section "Core GAP system" SecGAPcore

  SectionIn RO

  # Set output path to the installation directory
  SetOutPath $INSTDIR
  # Put files there
  File gap-4.10.2\*.*

  SetOutPath $INSTDIR\.libs
  File /r gap-4.10.2\.libs\*.*

  SetOutPath $INSTDIR\autom4te.cache
  File /r gap-4.10.2\autom4te.cache\*.*

  SetOutPath $INSTDIR\bin
  File /r gap-4.10.2\bin\*.*
  File gapicon.ico

  SetOutPath $INSTDIR\cnf
  File /r gap-4.10.2\cnf\*.*

  SetOutPath $INSTDIR\doc
  File /r gap-4.10.2\doc\*.*

  SetOutPath $INSTDIR\etc
  File /r gap-4.10.2\etc\*.*

  SetOutPath $INSTDIR\extern
  File /r gap-4.10.2\extern\*.*

  SetOutPath $INSTDIR\gen
  File /r gap-4.10.2\gen\*.*

  SetOutPath $INSTDIR\grp
  File /r gap-4.10.2\grp\*.*

  SetOutPath $INSTDIR\hpcgap
  File /r gap-4.10.2\hpcgap\*.*

  SetOutPath $INSTDIR\lib
  File /r gap-4.10.2\lib\*.*

  SetOutPath $INSTDIR\obj
  File /r gap-4.10.2\obj\*.*

  SetOutPath $INSTDIR\src
  File /r gap-4.10.2\src\*.*

  SetOutPath $INSTDIR\terminfo
  File /r gap-4.10.2\terminfo\*.*

  SetOutPath $INSTDIR\tst
  File /r gap-4.10.2\tst\*.*

  # restore initial output path
  SetOutPath $INSTDIR 

  # Store installation folder
  WriteRegStr HKCU "Software\GAP" "" $INSTDIR

  # Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  # rewriting install path in format /cygdrive/c/gap-4.10.2
  StrCpy $RXVT_PATH $INSTDIR
  ${WordReplace} $RXVT_PATH ":" ""  "+" $RXVT_PATH
  ${WordReplace} $RXVT_PATH "\" "/" "+" $RXVT_PATH

  # Write gap.bat file as follows:
  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  # set CYGWIN=nodosfilewarning
  # set LANG=en_US.UTF-8
  # set HOME=%HOMEDRIVE%%HOMEPATH%
  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  # cd %HOME%
  # start "GAP" C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3\mintty.exe -s 120,40 /proc/cygdrive/C/gap-4.10.2/bin/gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  # if NOT ["%errorlevel%"]==["0"] timeout 15
  # exit

  FileOpen $GAP_BAT $INSTDIR\bin\gap.bat w

  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  FileWrite $GAP_BAT "set TERMINFO=/proc/cygdrive/"
  FileWrite $GAP_BAT $RXVT_PATH
  FileWrite $GAP_BAT "/terminfo"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # set CYGWIN=nodosfilewarning
  FileWrite $GAP_BAT "set CYGWIN=nodosfilewarning"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # set LANG=en_US.UTF-8
  FileWrite $GAP_BAT "set LANG=en_US.UTF-8"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # set HOME=%HOMEDRIVE%%HOMEPATH%
  FileWrite $GAP_BAT "set HOME=%HOMEDRIVE%%HOMEPATH%"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  FileWrite $GAP_BAT "set PATH="
  FileWrite $GAP_BAT $INSTDIR
  FileWrite $GAP_BAT "\bin\i686-pc-cygwin-default32-kv3;%PATH%"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # cd %HOME%
  FileWrite $GAP_BAT "cd %HOME%"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # start "GAP" C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3\mintty.exe -s 120,40 /proc/cygdrive/C/gap-4.10.2/gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  FileWrite $GAP_BAT "start $\"GAP$\" " 
  FileWrite $GAP_BAT $INSTDIR
  FileWrite $GAP_BAT "\bin\i686-pc-cygwin-default32-kv3\mintty.exe -s 120,40 /proc/cygdrive/"
  FileWrite $GAP_BAT $RXVT_PATH
  FileWrite $GAP_BAT "/gap.exe -l /proc/cygdrive/"
  FileWrite $GAP_BAT $RXVT_PATH
  FileWrite $GAP_BAT " %*"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # if NOT ["%errorlevel%"]==["0"] timeout 15
  FileWrite $GAP_BAT "if NOT [$\"%errorlevel%$\"]==[$\"0$\"] timeout 15"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  # exit
  FileWrite $GAP_BAT "exit"
    FileWriteByte $GAP_BAT "13"
    FileWriteByte $GAP_BAT "10"

  FileClose $GAP_BAT


  # Write gaprxvt.bat file as follows:
  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  # set CYGWIN=nodosfilewarning
  # set LANG=en_US.ISO-8859-1
  # set HOME=%HOMEDRIVE%%HOMEPATH%
  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  # cd %HOME%
  # start "GAP" C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3\rxvt.exe -fn fixedsys -sl 1000 -e /proc/cygdrive/C/gap-4.10.2/gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  # if NOT ["%errorlevel%"]==["0"] timeout 15
  # exit

  FileOpen $GAPRXVT_BAT $INSTDIR\bin\gaprxvt.bat w

  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  FileWrite $GAPRXVT_BAT "set TERMINFO=/proc/cygdrive/"
  FileWrite $GAPRXVT_BAT $RXVT_PATH
  FileWrite $GAPRXVT_BAT "/terminfo"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # set CYGWIN=nodosfilewarning
  FileWrite $GAPRXVT_BAT "set CYGWIN=nodosfilewarning"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # set LANG=en_US.ISO-8859-1
  FileWrite $GAPRXVT_BAT "set LANG=en_US.ISO-8859-1"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"     

  # set HOME=%HOMEDRIVE%%HOMEPATH%
  FileWrite $GAPRXVT_BAT "set HOME=%HOMEDRIVE%%HOMEPATH%"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  FileWrite $GAPRXVT_BAT "set PATH="
  FileWrite $GAPRXVT_BAT $INSTDIR 
  FileWrite $GAPRXVT_BAT "\bin\i686-pc-cygwin-default32-kv3;%PATH%"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # cd %HOME%
  FileWrite $GAPRXVT_BAT "cd %HOME%"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # start "GAP" C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3\rxvt.exe -fn fixedsys -sl 1000 -e /proc/cygdrive/C/gap-4.10.2/gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  FileWrite $GAPRXVT_BAT "start $\"GAP$\" " 
  FileWrite $GAPRXVT_BAT $INSTDIR
  FileWrite $GAPRXVT_BAT "\bin\i686-pc-cygwin-default32-kv3\rxvt.exe -fn fixedsys -sl 1000 -e /proc/cygdrive/"
  FileWrite $GAPRXVT_BAT $RXVT_PATH
  FileWrite $GAPRXVT_BAT "/gap.exe -l /proc/cygdrive/"
  FileWrite $GAPRXVT_BAT $RXVT_PATH
  FileWrite $GAPRXVT_BAT " %*"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # if NOT ["%errorlevel%"]==["0"] timeout 15
  FileWrite $GAPRXVT_BAT "if NOT [$\"%errorlevel%$\"]==[$\"0$\"] timeout 15"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"

  # exit
  FileWrite $GAPRXVT_BAT "exit"
    FileWriteByte $GAPRXVT_BAT "13"
    FileWriteByte $GAPRXVT_BAT "10"
  FileClose $GAPRXVT_BAT


  # Write gapcmd.bat file as follows:
  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  # set CYGWIN=nodosfilewarning
  # set LANG=en_US.UTF-8
  # set HOME=%HOMEDRIVE%%HOMEPATH%
  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  # cd %HOME%
  # C:\gap-4.10.2\gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  # if NOT ["%errorlevel%"]==["0"] timeout 15
  # exit

  FileOpen $GAPCMD_BAT $INSTDIR\bin\gapcmd.bat w

  # set TERMINFO=/proc/cygdrive/c/gap-4.10.2/terminfo
  FileWrite $GAPCMD_BAT "set TERMINFO=/proc/cygdrive/"
  FileWrite $GAPCMD_BAT $RXVT_PATH
  FileWrite $GAPCMD_BAT "/terminfo"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # set CYGWIN=nodosfilewarning
  FileWrite $GAPCMD_BAT "set CYGWIN=nodosfilewarning"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # set LANG=en_US.UTF-8
  FileWrite $GAPCMD_BAT "set LANG=en_US.UTF-8"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"   

  # set HOME=%HOMEDRIVE%%HOMEPATH%
  FileWrite $GAPCMD_BAT "set HOME=%HOMEDRIVE%%HOMEPATH%"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # set PATH=C:\gap-4.10.2\bin\i686-pc-cygwin-default32-kv3;%PATH%
  FileWrite $GAPCMD_BAT "set PATH="
  FileWrite $GAPCMD_BAT $INSTDIR
  FileWrite $GAPCMD_BAT "\bin\i686-pc-cygwin-default32-kv3;%PATH%"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # cd %HOME%
  FileWrite $GAPCMD_BAT "cd %HOME%"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # C:\gap-4.10.2\gap.exe -l /proc/cygdrive/C/gap-4.10.2 %*
  FileWrite $GAPCMD_BAT $INSTDIR
  FileWrite $GAPCMD_BAT "\gap.exe -l /proc/cygdrive/"
  FileWrite $GAPCMD_BAT $RXVT_PATH 
  FileWrite $GAPCMD_BAT " %*"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"


  # if NOT ["%errorlevel%"]==["0"] timeout 15
  FileWrite $GAPCMD_BAT "if NOT [$\"%errorlevel%$\"]==[$\"0$\"] timeout 15"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"

  # exit
  FileWrite $GAPCMD_BAT "exit"
    FileWriteByte $GAPCMD_BAT "13"
    FileWriteByte $GAPCMD_BAT "10"
  FileClose $GAPCMD_BAT


  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\GAP $GAP_VER.lnk" "$INSTDIR\bin\gap.bat" "" "$INSTDIR\bin\gapicon.ico" 0
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\GAP Tutorial.lnk" "$INSTDIR\doc\tut\chap0.html" "" "$INSTDIR\doc\tut\chap0.html" 0
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\GAP Reference Manual.lnk" "$INSTDIR\doc\ref\chap0.html" "" "$INSTDIR\doc\ref\chap0.html" 0
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall GAP $GAP_VER.lnk" "$INSTDIR\Uninstall.exe"

  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

# This part is autogenerated by GAP
#######################################################################
#
# Needed packages
#
SectionGroup "Needed packages" SecGAPpkgsNeeded

#######################################################################
#
# GAPDoc
#
Section "GAPDoc" SecGAPpkg_gapdoc 
SectionIn RO 
SetOutPath $INSTDIR\pkg\GAPDoc-1.6.2
File /r gap-4.10.2\pkg\GAPDoc-1.6.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# PrimGrp
#
Section "PrimGrp" SecGAPpkg_primgrp 
SectionIn RO 
SetOutPath $INSTDIR\pkg\primgrp-3.3.2
File /r gap-4.10.2\pkg\primgrp-3.3.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SmallGrp
#
Section "SmallGrp" SecGAPpkg_smallgrp 
SectionIn RO 
SetOutPath $INSTDIR\pkg\SmallGrp-1.3
File /r gap-4.10.2\pkg\SmallGrp-1.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# TransGrp
#
Section "TransGrp" SecGAPpkg_transgrp 
SectionIn RO 
SetOutPath $INSTDIR\pkg\transgrp
File /r gap-4.10.2\pkg\transgrp\*.* 
SetOutPath $INSTDIR 
SectionEnd 

SectionGroupEnd 
# Needed packages end here

#######################################################################
#
# Default packages
#
SectionGroup "Default packages" SecGAPpkgsDefault

#######################################################################
#
# AClib
#
Section "AClib" SecGAPpkg_aclib 
SetOutPath $INSTDIR\pkg\aclib-1.3.1
File /r gap-4.10.2\pkg\aclib-1.3.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Alnuth
#
Section "Alnuth" SecGAPpkg_alnuth 
SetOutPath $INSTDIR\pkg\alnuth-3.1.1
File /r gap-4.10.2\pkg\alnuth-3.1.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# AtlasRep
#
Section "AtlasRep" SecGAPpkg_atlasrep 
SetOutPath $INSTDIR\pkg\atlasrep
File /r gap-4.10.2\pkg\atlasrep\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# AutoDoc
#
Section "AutoDoc" SecGAPpkg_autodoc 
SetOutPath $INSTDIR\pkg\AutoDoc-2019.05.20
File /r gap-4.10.2\pkg\AutoDoc-2019.05.20\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# AutPGrp
#
Section "AutPGrp" SecGAPpkg_autpgrp 
SetOutPath $INSTDIR\pkg\autpgrp-1.10
File /r gap-4.10.2\pkg\autpgrp-1.10\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Browse
#
Section "Browse" SecGAPpkg_browse 
SetOutPath $INSTDIR\pkg\Browse
File /r gap-4.10.2\pkg\Browse\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CRISP
#
Section "CRISP" SecGAPpkg_crisp 
SetOutPath $INSTDIR\pkg\crisp-1.4.4
File /r gap-4.10.2\pkg\crisp-1.4.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Cryst
#
Section "Cryst" SecGAPpkg_cryst 
SetOutPath $INSTDIR\pkg\cryst
File /r gap-4.10.2\pkg\cryst\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CrystCat
#
Section "CrystCat" SecGAPpkg_crystcat 
SetOutPath $INSTDIR\pkg\crystcat
File /r gap-4.10.2\pkg\crystcat\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CTblLib
#
Section "CTblLib" SecGAPpkg_ctbllib 
SetOutPath $INSTDIR\pkg\ctbllib
File /r gap-4.10.2\pkg\ctbllib\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# DESIGN
#
Section "DESIGN" SecGAPpkg_design 
SetOutPath $INSTDIR\pkg\design-1.7
File /r gap-4.10.2\pkg\design-1.7\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Example
#
Section "Example" SecGAPpkg_example 
SetOutPath $INSTDIR\pkg\Example-4.1.1
File /r gap-4.10.2\pkg\Example-4.1.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FactInt
#
Section "FactInt" SecGAPpkg_factint 
SetOutPath $INSTDIR\pkg\FactInt-1.6.2
File /r gap-4.10.2\pkg\FactInt-1.6.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FGA
#
Section "FGA" SecGAPpkg_fga 
SetOutPath $INSTDIR\pkg\fga
File /r gap-4.10.2\pkg\fga\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Forms
#
Section "Forms" SecGAPpkg_forms 
SetOutPath $INSTDIR\pkg\forms
File /r gap-4.10.2\pkg\forms\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# genss
#
Section "genss" SecGAPpkg_genss 
SetOutPath $INSTDIR\pkg\genss-1.6.5
File /r gap-4.10.2\pkg\genss-1.6.5\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GRAPE
#
Section "GRAPE" SecGAPpkg_grape 
SetOutPath $INSTDIR\pkg\grape-4.8.2
File /r gap-4.10.2\pkg\grape-4.8.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GUAVA
#
Section "GUAVA" SecGAPpkg_guava 
SetOutPath $INSTDIR\pkg\guava-3.14
File /r gap-4.10.2\pkg\guava-3.14\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# IO
#
Section "IO" SecGAPpkg_io 
SetOutPath $INSTDIR\pkg\io-4.6.0
File /r gap-4.10.2\pkg\io-4.6.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# IRREDSOL
#
Section "IRREDSOL" SecGAPpkg_irredsol 
SetOutPath $INSTDIR\pkg\irredsol-1.4
File /r gap-4.10.2\pkg\irredsol-1.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LAGUNA
#
Section "LAGUNA" SecGAPpkg_laguna 
SetOutPath $INSTDIR\pkg\laguna-3.9.3
File /r gap-4.10.2\pkg\laguna-3.9.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# orb
#
Section "orb" SecGAPpkg_orb 
SetOutPath $INSTDIR\pkg\orb-4.8.2
File /r gap-4.10.2\pkg\orb-4.8.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Polenta
#
Section "Polenta" SecGAPpkg_polenta 
SetOutPath $INSTDIR\pkg\polenta-1.3.8
File /r gap-4.10.2\pkg\polenta-1.3.8\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Polycyclic
#
Section "Polycyclic" SecGAPpkg_polycyclic 
SetOutPath $INSTDIR\pkg\polycyclic-2.14
File /r gap-4.10.2\pkg\polycyclic-2.14\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# RadiRoot
#
Section "RadiRoot" SecGAPpkg_radiroot 
SetOutPath $INSTDIR\pkg\radiroot-2.8
File /r gap-4.10.2\pkg\radiroot-2.8\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# recog
#
Section "recog" SecGAPpkg_recog 
SetOutPath $INSTDIR\pkg\recog-1.3.2
File /r gap-4.10.2\pkg\recog-1.3.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ResClasses
#
Section "ResClasses" SecGAPpkg_resclasses 
SetOutPath $INSTDIR\pkg\resclasses-4.7.2
File /r gap-4.10.2\pkg\resclasses-4.7.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SONATA
#
Section "SONATA" SecGAPpkg_sonata 
SetOutPath $INSTDIR\pkg\sonata-2.9.1
File /r gap-4.10.2\pkg\sonata-2.9.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Sophus
#
Section "Sophus" SecGAPpkg_sophus 
SetOutPath $INSTDIR\pkg\sophus-1.24
File /r gap-4.10.2\pkg\sophus-1.24\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SpinSym
#
Section "SpinSym" SecGAPpkg_spinsym 
SetOutPath $INSTDIR\pkg\spinsym-1.5.1
File /r gap-4.10.2\pkg\spinsym-1.5.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# TomLib
#
Section "TomLib" SecGAPpkg_tomlib 
SetOutPath $INSTDIR\pkg\tomlib-1.2.8
File /r gap-4.10.2\pkg\tomlib-1.2.8\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# utils
#
Section "utils" SecGAPpkg_utils 
SetOutPath $INSTDIR\pkg\utils-0.63
File /r gap-4.10.2\pkg\utils-0.63\*.* 
SetOutPath $INSTDIR 
SectionEnd 

SectionGroupEnd 
# Default packages end here

#######################################################################
#
# Specialised  packages
#
SectionGroup "Specialised  packages" SecGAPpkgsSpecial

#######################################################################
#
# 4ti2Interface
#
Section "4ti2Interface" SecGAPpkg_4ti2interface 
SetOutPath $INSTDIR\pkg\4ti2Interface-2018.07.06
File /r gap-4.10.2\pkg\4ti2Interface-2018.07.06\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Automata
#
Section "Automata" SecGAPpkg_automata 
SetOutPath $INSTDIR\pkg\automata-1.14
File /r gap-4.10.2\pkg\automata-1.14\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# AutomGrp
#
Section "AutomGrp" SecGAPpkg_automgrp 
SetOutPath $INSTDIR\pkg\automgrp
File /r gap-4.10.2\pkg\automgrp\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CAP
#
Section "CAP" SecGAPpkg_cap 
SetOutPath $INSTDIR\pkg\CAP-2019.06.07
File /r gap-4.10.2\pkg\CAP-2019.06.07\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Circle
#
Section "Circle" SecGAPpkg_circle 
SetOutPath $INSTDIR\pkg\circle-1.6.1
File /r gap-4.10.2\pkg\circle-1.6.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# cohomolo
#
Section "cohomolo" SecGAPpkg_cohomolo 
SetOutPath $INSTDIR\pkg\cohomolo-1.6.7
File /r gap-4.10.2\pkg\cohomolo-1.6.7\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Congruence
#
Section "Congruence" SecGAPpkg_congruence 
SetOutPath $INSTDIR\pkg\congruence-1.2.3
File /r gap-4.10.2\pkg\congruence-1.2.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Convex
#
Section "Convex" SecGAPpkg_convex 
SetOutPath $INSTDIR\pkg\Convex-2019.05.01
File /r gap-4.10.2\pkg\Convex-2019.05.01\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CoReLG
#
Section "CoReLG" SecGAPpkg_corelg 
SetOutPath $INSTDIR\pkg\corelg
File /r gap-4.10.2\pkg\corelg\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# CRIME
#
Section "CRIME" SecGAPpkg_crime 
SetOutPath $INSTDIR\pkg\crime-1.5
File /r gap-4.10.2\pkg\crime-1.5\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# crypting
#
Section "crypting" SecGAPpkg_crypting 
SetOutPath $INSTDIR\pkg\crypting-0.9
File /r gap-4.10.2\pkg\crypting-0.9\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Cubefree
#
Section "Cubefree" SecGAPpkg_cubefree 
SetOutPath $INSTDIR\pkg\cubefree
File /r gap-4.10.2\pkg\cubefree\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# cvec
#
Section "cvec" SecGAPpkg_cvec 
SetOutPath $INSTDIR\pkg\cvec-2.7.2
File /r gap-4.10.2\pkg\cvec-2.7.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# datastructures
#
Section "datastructures" SecGAPpkg_datastructures 
SetOutPath $INSTDIR\pkg\datastructures-0.2.3
File /r gap-4.10.2\pkg\datastructures-0.2.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Digraphs
#
Section "Digraphs" SecGAPpkg_digraphs 
SetOutPath $INSTDIR\pkg\digraphs-0.15.2
File /r gap-4.10.2\pkg\digraphs-0.15.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# EDIM
#
Section "EDIM" SecGAPpkg_edim 
SetOutPath $INSTDIR\pkg\EDIM-1.3.3
File /r gap-4.10.2\pkg\EDIM-1.3.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ExamplesForHomalg
#
Section "ExamplesForHomalg" SecGAPpkg_examplesforhomalg 
SetOutPath $INSTDIR\pkg\ExamplesForHomalg-2019.01.07
File /r gap-4.10.2\pkg\ExamplesForHomalg-2019.01.07\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FinInG
#
Section "FinInG" SecGAPpkg_fining 
SetOutPath $INSTDIR\pkg\fining
File /r gap-4.10.2\pkg\fining\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FORMAT
#
Section "FORMAT" SecGAPpkg_format 
SetOutPath $INSTDIR\pkg\format-1.4.1
File /r gap-4.10.2\pkg\format-1.4.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FPLSA
#
Section "FPLSA" SecGAPpkg_fplsa 
SetOutPath $INSTDIR\pkg\FPLSA-1.2.3
File /r gap-4.10.2\pkg\FPLSA-1.2.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# FR
#
Section "FR" SecGAPpkg_fr 
SetOutPath $INSTDIR\pkg\fr-2.4.6
File /r gap-4.10.2\pkg\fr-2.4.6\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Francy
#
Section "Francy" SecGAPpkg_francy 
SetOutPath $INSTDIR\pkg\francy-1.2.4
File /r gap-4.10.2\pkg\francy-1.2.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Gauss
#
Section "Gauss" SecGAPpkg_gauss 
SetOutPath $INSTDIR\pkg\Gauss-2018.09.08
File /r gap-4.10.2\pkg\Gauss-2018.09.08\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GaussForHomalg
#
Section "GaussForHomalg" SecGAPpkg_gaussforhomalg 
SetOutPath $INSTDIR\pkg\GaussForHomalg-2019.02.01
File /r gap-4.10.2\pkg\GaussForHomalg-2019.02.01\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GBNP
#
Section "GBNP" SecGAPpkg_gbnp 
SetOutPath $INSTDIR\pkg\gbnp
File /r gap-4.10.2\pkg\gbnp\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GeneralizedMorphismsForCAP
#
Section "GeneralizedMorphismsForCAP" SecGAPpkg_generalizedmorphismsforcap 
SetOutPath $INSTDIR\pkg\GeneralizedMorphismsForCAP-2019.01.16
File /r gap-4.10.2\pkg\GeneralizedMorphismsForCAP-2019.01.16\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GradedModules
#
Section "GradedModules" SecGAPpkg_gradedmodules 
SetOutPath $INSTDIR\pkg\GradedModules-2019.01.05
File /r gap-4.10.2\pkg\GradedModules-2019.01.05\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GradedRingForHomalg
#
Section "GradedRingForHomalg" SecGAPpkg_gradedringforhomalg 
SetOutPath $INSTDIR\pkg\GradedRingForHomalg-2019.04.02
File /r gap-4.10.2\pkg\GradedRingForHomalg-2019.04.02\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# groupoids
#
Section "groupoids" SecGAPpkg_groupoids 
SetOutPath $INSTDIR\pkg\groupoids-1.66
File /r gap-4.10.2\pkg\groupoids-1.66\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# GrpConst
#
Section "GrpConst" SecGAPpkg_grpconst 
SetOutPath $INSTDIR\pkg\grpconst-2.6.1
File /r gap-4.10.2\pkg\grpconst-2.6.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Guarana
#
Section "Guarana" SecGAPpkg_guarana 
SetOutPath $INSTDIR\pkg\guarana-0.96.2
File /r gap-4.10.2\pkg\guarana-0.96.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# HAP
#
Section "HAP" SecGAPpkg_hap 
SetOutPath $INSTDIR\pkg\Hap1.19
File /r gap-4.10.2\pkg\Hap1.19\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# HAPcryst
#
Section "HAPcryst" SecGAPpkg_hapcryst 
SetOutPath $INSTDIR\pkg\HAPcryst
File /r gap-4.10.2\pkg\HAPcryst\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# hecke
#
Section "hecke" SecGAPpkg_hecke 
SetOutPath $INSTDIR\pkg\hecke-1.5.2
File /r gap-4.10.2\pkg\hecke-1.5.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# homalg
#
Section "homalg" SecGAPpkg_homalg 
SetOutPath $INSTDIR\pkg\homalg-2019.02.03
File /r gap-4.10.2\pkg\homalg-2019.02.03\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# HomalgToCAS
#
Section "HomalgToCAS" SecGAPpkg_homalgtocas 
SetOutPath $INSTDIR\pkg\HomalgToCAS-2019.02.01
File /r gap-4.10.2\pkg\HomalgToCAS-2019.02.01\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# idrel
#
Section "idrel" SecGAPpkg_idrel 
SetOutPath $INSTDIR\pkg\idrel-2.43
File /r gap-4.10.2\pkg\idrel-2.43\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# IntPic
#
Section "IntPic" SecGAPpkg_intpic 
SetOutPath $INSTDIR\pkg\IntPic-0.2.3
File /r gap-4.10.2\pkg\IntPic-0.2.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# IO_ForHomalg
#
Section "IO_ForHomalg" SecGAPpkg_io_forhomalg 
SetOutPath $INSTDIR\pkg\IO_ForHomalg-2019.01.01
File /r gap-4.10.2\pkg\IO_ForHomalg-2019.01.01\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# json
#
Section "json" SecGAPpkg_json 
SetOutPath $INSTDIR\pkg\json-2.0.0
File /r gap-4.10.2\pkg\json-2.0.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# JupyterKernel
#
Section "JupyterKernel" SecGAPpkg_jupyterkernel 
SetOutPath $INSTDIR\pkg\JupyterKernel-1.3
File /r gap-4.10.2\pkg\JupyterKernel-1.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# JupyterViz
#
Section "JupyterViz" SecGAPpkg_jupyterviz 
SetOutPath $INSTDIR\pkg\jupyterviz-1.5.1
File /r gap-4.10.2\pkg\jupyterviz-1.5.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# kan
#
Section "kan" SecGAPpkg_kan 
SetOutPath $INSTDIR\pkg\kan-1.29
File /r gap-4.10.2\pkg\kan-1.29\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# kbmag
#
Section "kbmag" SecGAPpkg_kbmag 
SetOutPath $INSTDIR\pkg\kbmag-1.5.8
File /r gap-4.10.2\pkg\kbmag-1.5.8\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LieAlgDB
#
Section "LieAlgDB" SecGAPpkg_liealgdb 
SetOutPath $INSTDIR\pkg\liealgdb-2.2
File /r gap-4.10.2\pkg\liealgdb-2.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LiePRing
#
Section "LiePRing" SecGAPpkg_liepring 
SetOutPath $INSTDIR\pkg\liepring-1.9.2
File /r gap-4.10.2\pkg\liepring-1.9.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LieRing
#
Section "LieRing" SecGAPpkg_liering 
SetOutPath $INSTDIR\pkg\liering-2.4.1
File /r gap-4.10.2\pkg\liering-2.4.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LinearAlgebraForCAP
#
Section "LinearAlgebraForCAP" SecGAPpkg_linearalgebraforcap 
SetOutPath $INSTDIR\pkg\LinearAlgebraForCAP-2019.01.16
File /r gap-4.10.2\pkg\LinearAlgebraForCAP-2019.01.16\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# LocalizeRingForHomalg
#
Section "LocalizeRingForHomalg" SecGAPpkg_localizeringforhomalg 
SetOutPath $INSTDIR\pkg\LocalizeRingForHomalg-2018.02.04
File /r gap-4.10.2\pkg\LocalizeRingForHomalg-2018.02.04\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# loops
#
Section "loops" SecGAPpkg_loops 
SetOutPath $INSTDIR\pkg\loops-3.4.1
File /r gap-4.10.2\pkg\loops-3.4.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# lpres
#
Section "lpres" SecGAPpkg_lpres 
SetOutPath $INSTDIR\pkg\lpres-1.0.1
File /r gap-4.10.2\pkg\lpres-1.0.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# MajoranaAlgebras
#
Section "MajoranaAlgebras" SecGAPpkg_majoranaalgebras 
SetOutPath $INSTDIR\pkg\MajoranaAlgebras-1.4
File /r gap-4.10.2\pkg\MajoranaAlgebras-1.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# MapClass
#
Section "MapClass" SecGAPpkg_mapclass 
SetOutPath $INSTDIR\pkg\MapClass-1.4.4
File /r gap-4.10.2\pkg\MapClass-1.4.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# matgrp
#
Section "matgrp" SecGAPpkg_matgrp 
SetOutPath $INSTDIR\pkg\matgrp
File /r gap-4.10.2\pkg\matgrp\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# MatricesForHomalg
#
Section "MatricesForHomalg" SecGAPpkg_matricesforhomalg 
SetOutPath $INSTDIR\pkg\MatricesForHomalg-2019.03.08
File /r gap-4.10.2\pkg\MatricesForHomalg-2019.03.08\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ModIsom
#
Section "ModIsom" SecGAPpkg_modisom 
SetOutPath $INSTDIR\pkg\modisom-2.5.0
File /r gap-4.10.2\pkg\modisom-2.5.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ModulePresentationsForCAP
#
Section "ModulePresentationsForCAP" SecGAPpkg_modulepresentationsforcap 
SetOutPath $INSTDIR\pkg\ModulePresentationsForCAP-2019.01.16
File /r gap-4.10.2\pkg\ModulePresentationsForCAP-2019.01.16\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Modules
#
Section "Modules" SecGAPpkg_modules 
SetOutPath $INSTDIR\pkg\Modules-2019.02.03
File /r gap-4.10.2\pkg\Modules-2019.02.03\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# MonoidalCategories
#
Section "MonoidalCategories" SecGAPpkg_monoidalcategories 
SetOutPath $INSTDIR\pkg\MonoidalCategories-2019.06.07
File /r gap-4.10.2\pkg\MonoidalCategories-2019.06.07\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Nilmat
#
Section "Nilmat" SecGAPpkg_nilmat 
SetOutPath $INSTDIR\pkg\nilmat-1.3
File /r gap-4.10.2\pkg\nilmat-1.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# nq
#
Section "nq" SecGAPpkg_nq 
SetOutPath $INSTDIR\pkg\nq-2.5.4
File /r gap-4.10.2\pkg\nq-2.5.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# NumericalSgps
#
Section "NumericalSgps" SecGAPpkg_numericalsgps 
SetOutPath $INSTDIR\pkg\NumericalSgps-1.2.0
File /r gap-4.10.2\pkg\NumericalSgps-1.2.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# OpenMath
#
Section "OpenMath" SecGAPpkg_openmath 
SetOutPath $INSTDIR\pkg\OpenMath-11.4.2
File /r gap-4.10.2\pkg\OpenMath-11.4.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# PackageManager
#
Section "PackageManager" SecGAPpkg_packagemanager 
SetOutPath $INSTDIR\pkg\PackageManager-0.4
File /r gap-4.10.2\pkg\PackageManager-0.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# PatternClass
#
Section "PatternClass" SecGAPpkg_patternclass 
SetOutPath $INSTDIR\pkg\PatternClass-2.4.2
File /r gap-4.10.2\pkg\PatternClass-2.4.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# permut
#
Section "permut" SecGAPpkg_permut 
SetOutPath $INSTDIR\pkg\permut-2.0.3
File /r gap-4.10.2\pkg\permut-2.0.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# polymaking
#
Section "polymaking" SecGAPpkg_polymaking 
SetOutPath $INSTDIR\pkg\polymaking-0.8.2
File /r gap-4.10.2\pkg\polymaking-0.8.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# profiling
#
Section "profiling" SecGAPpkg_profiling 
SetOutPath $INSTDIR\pkg\profiling-2.2.1
File /r gap-4.10.2\pkg\profiling-2.2.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# QPA
#
Section "QPA" SecGAPpkg_qpa 
SetOutPath $INSTDIR\pkg\qpa-version-1.29
File /r gap-4.10.2\pkg\qpa-version-1.29\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# QuaGroup
#
Section "QuaGroup" SecGAPpkg_quagroup 
SetOutPath $INSTDIR\pkg\quagroup-1.8.1
File /r gap-4.10.2\pkg\quagroup-1.8.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# RCWA
#
Section "RCWA" SecGAPpkg_rcwa 
SetOutPath $INSTDIR\pkg\rcwa-4.6.4
File /r gap-4.10.2\pkg\rcwa-4.6.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# RDS
#
Section "RDS" SecGAPpkg_rds 
SetOutPath $INSTDIR\pkg\rds-1.7
File /r gap-4.10.2\pkg\rds-1.7\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Repsn
#
Section "Repsn" SecGAPpkg_repsn 
SetOutPath $INSTDIR\pkg\repsn-3.1.0
File /r gap-4.10.2\pkg\repsn-3.1.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# RingsForHomalg
#
Section "RingsForHomalg" SecGAPpkg_ringsforhomalg 
SetOutPath $INSTDIR\pkg\RingsForHomalg-2019.02.01
File /r gap-4.10.2\pkg\RingsForHomalg-2019.02.01\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SCO
#
Section "SCO" SecGAPpkg_sco 
SetOutPath $INSTDIR\pkg\SCO-2017.09.10
File /r gap-4.10.2\pkg\SCO-2017.09.10\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SCSCP
#
Section "SCSCP" SecGAPpkg_scscp 
SetOutPath $INSTDIR\pkg\SCSCP-2.3.0
File /r gap-4.10.2\pkg\SCSCP-2.3.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Semigroups
#
Section "Semigroups" SecGAPpkg_semigroups 
SetOutPath $INSTDIR\pkg\semigroups-3.1.3
File /r gap-4.10.2\pkg\semigroups-3.1.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SglPPow
#
Section "SglPPow" SecGAPpkg_sglppow 
SetOutPath $INSTDIR\pkg\sglppow-2.1
File /r gap-4.10.2\pkg\sglppow-2.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SgpViz
#
Section "SgpViz" SecGAPpkg_sgpviz 
SetOutPath $INSTDIR\pkg\SgpViz-0.999.4
File /r gap-4.10.2\pkg\SgpViz-0.999.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# simpcomp
#
Section "simpcomp" SecGAPpkg_simpcomp 
SetOutPath $INSTDIR\pkg\simpcomp
File /r gap-4.10.2\pkg\simpcomp\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# singular
#
Section "singular" SecGAPpkg_singular 
SetOutPath $INSTDIR\pkg\singular-2019.02.22
File /r gap-4.10.2\pkg\singular-2019.02.22\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SLA
#
Section "SLA" SecGAPpkg_sla 
SetOutPath $INSTDIR\pkg\sla-1.5.2
File /r gap-4.10.2\pkg\sla-1.5.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Smallsemi
#
Section "Smallsemi" SecGAPpkg_smallsemi 
SetOutPath $INSTDIR\pkg\smallsemi-0.6.11
File /r gap-4.10.2\pkg\smallsemi-0.6.11\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# SymbCompCC
#
Section "SymbCompCC" SecGAPpkg_symbcompcc 
SetOutPath $INSTDIR\pkg\SymbCompCC-1.3
File /r gap-4.10.2\pkg\SymbCompCC-1.3\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Thelma
#
Section "Thelma" SecGAPpkg_thelma 
SetOutPath $INSTDIR\pkg\Thelma-1.02
File /r gap-4.10.2\pkg\Thelma-1.02\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ToolsForHomalg
#
Section "ToolsForHomalg" SecGAPpkg_toolsforhomalg 
SetOutPath $INSTDIR\pkg\ToolsForHomalg-2019.02.17
File /r gap-4.10.2\pkg\ToolsForHomalg-2019.02.17\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Toric
#
Section "Toric" SecGAPpkg_toric 
SetOutPath $INSTDIR\pkg\Toric-1.9.4
File /r gap-4.10.2\pkg\Toric-1.9.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ToricVarieties
#
Section "ToricVarieties" SecGAPpkg_toricvarieties 
SetOutPath $INSTDIR\pkg\ToricVarieties
File /r gap-4.10.2\pkg\ToricVarieties\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Unipot
#
Section "Unipot" SecGAPpkg_unipot 
SetOutPath $INSTDIR\pkg\unipot-1.4
File /r gap-4.10.2\pkg\unipot-1.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# UnitLib
#
Section "UnitLib" SecGAPpkg_unitlib 
SetOutPath $INSTDIR\pkg\unitlib-4.0.0
File /r gap-4.10.2\pkg\unitlib-4.0.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# uuid
#
Section "uuid" SecGAPpkg_uuid 
SetOutPath $INSTDIR\pkg\uuid-0.6
File /r gap-4.10.2\pkg\uuid-0.6\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# walrus
#
Section "walrus" SecGAPpkg_walrus 
SetOutPath $INSTDIR\pkg\walrus-0.99
File /r gap-4.10.2\pkg\walrus-0.99\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Wedderga
#
Section "Wedderga" SecGAPpkg_wedderga 
SetOutPath $INSTDIR\pkg\wedderga-4.9.5
File /r gap-4.10.2\pkg\wedderga-4.9.5\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# XMod
#
Section "XMod" SecGAPpkg_xmod 
SetOutPath $INSTDIR\pkg\XMod-2.73
File /r gap-4.10.2\pkg\XMod-2.73\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# XModAlg
#
Section "XModAlg" SecGAPpkg_xmodalg 
SetOutPath $INSTDIR\pkg\XModAlg-1.17
File /r gap-4.10.2\pkg\XModAlg-1.17\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# YangBaxter
#
Section "YangBaxter" SecGAPpkg_yangbaxter 
SetOutPath $INSTDIR\pkg\YangBaxter-0.7.0
File /r gap-4.10.2\pkg\YangBaxter-0.7.0\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ZeroMQInterface
#
Section "ZeroMQInterface" SecGAPpkg_zeromqinterface 
SetOutPath $INSTDIR\pkg\ZeroMQInterface-0.11
File /r gap-4.10.2\pkg\ZeroMQInterface-0.11\*.* 
SetOutPath $INSTDIR 
SectionEnd 

SectionGroupEnd 
# Specialised packages end here

#######################################################################
#
# Packages that do not work under Windows
#
SectionGroup "Packages requiring UNIX/Linux" SecGAPpkgsNoWindows

#######################################################################
#
# ACE
#
Section "ACE" SecGAPpkg_ace 
SetOutPath $INSTDIR\pkg\ace-5.2
File /r gap-4.10.2\pkg\ace-5.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ANUPQ
#
Section "ANUPQ" SecGAPpkg_anupq 
SetOutPath $INSTDIR\pkg\anupq-3.2.1
File /r gap-4.10.2\pkg\anupq-3.2.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# Carat
#
Section "Carat" SecGAPpkg_carat 
SetOutPath $INSTDIR\pkg\carat
File /r gap-4.10.2\pkg\carat\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# curlInterface
#
Section "curlInterface" SecGAPpkg_curlinterface 
SetOutPath $INSTDIR\pkg\curlInterface-2.1.1
File /r gap-4.10.2\pkg\curlInterface-2.1.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# DeepThought
#
Section "DeepThought" SecGAPpkg_deepthought 
SetOutPath $INSTDIR\pkg\DeepThought-1.0.2
File /r gap-4.10.2\pkg\DeepThought-1.0.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# float
#
Section "float" SecGAPpkg_float 
SetOutPath $INSTDIR\pkg\float-0.9.1
File /r gap-4.10.2\pkg\float-0.9.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# fwtree
#
Section "fwtree" SecGAPpkg_fwtree 
SetOutPath $INSTDIR\pkg\fwtree-1.1
File /r gap-4.10.2\pkg\fwtree-1.1\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# HeLP
#
Section "HeLP" SecGAPpkg_help 
SetOutPath $INSTDIR\pkg\HeLP-3.4
File /r gap-4.10.2\pkg\HeLP-3.4\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# ITC
#
Section "ITC" SecGAPpkg_itc 
SetOutPath $INSTDIR\pkg\itc-1.5
File /r gap-4.10.2\pkg\itc-1.5\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# NormalizInterface
#
Section "NormalizInterface" SecGAPpkg_normalizinterface 
SetOutPath $INSTDIR\pkg\NormalizInterface-1.0.2
File /r gap-4.10.2\pkg\NormalizInterface-1.0.2\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# PolymakeInterface
#
Section "PolymakeInterface" SecGAPpkg_polymakeinterface 
SetOutPath $INSTDIR\pkg\PolymakeInterface-2019.03.26
File /r gap-4.10.2\pkg\PolymakeInterface-2019.03.26\*.* 
SetOutPath $INSTDIR 
SectionEnd 

#######################################################################
#
# XGAP
#
Section "XGAP" SecGAPpkg_xgap 
SetOutPath $INSTDIR\pkg\xgap-4.30
File /r gap-4.10.2\pkg\xgap-4.30\*.* 
SetOutPath $INSTDIR 
SectionEnd 

SectionGroupEnd 
# Packages that do not work under Windows end here

#######################################################################
# Descriptions

# Language strings
LangString DESC_SecGAPcore ${LANG_ENGLISH} "The core GAP system (GAP kernel, GAP library, data libraries, manuals and tests)"

LangString DESC_SecGAPpkgsNeeded ${LANG_ENGLISH} "Packages needed to run GAP (in addition to these we advise to install also at least all default packages, some of which extend the GAP functionality quite substantially)"
LangString DESC_SecGAPpkgsDefault ${LANG_ENGLISH} "Default packages (loaded by default when GAP starts), and a selection of other packages and data libraries. We advise to select the whole group since dependencies between individual packages are not traced"
LangString DESC_SecGAPpkgsSpecial ${LANG_ENGLISH} "Optional packages (some of these are for an expert installation; we advise to select the whole group since dependencies between individual packages are not traced)"
LangString DESC_SecGAPpkgsNoWindows ${LANG_ENGLISH} "Packages that do not work under Windows (install them if you wish to be able to access their code and documentation)"

LangString DESC_SecGAPpkg_4ti2interface ${LANG_ENGLISH} "A link to 4ti2"
LangString DESC_SecGAPpkg_ace ${LANG_ENGLISH} "Advanced Coset Enumerator"
LangString DESC_SecGAPpkg_aclib ${LANG_ENGLISH} "Almost Crystallographic Groups - A Library and Algorithms"
LangString DESC_SecGAPpkg_alnuth ${LANG_ENGLISH} "Algebraic number theory and an interface to PARI/GP"
LangString DESC_SecGAPpkg_anupq ${LANG_ENGLISH} "ANU p-Quotient"
LangString DESC_SecGAPpkg_atlasrep ${LANG_ENGLISH} "A GAP Interface to the Atlas of Group Representations"
LangString DESC_SecGAPpkg_autodoc ${LANG_ENGLISH} "Generate documentation from GAP source code"
LangString DESC_SecGAPpkg_automata ${LANG_ENGLISH} "A package on automata"
LangString DESC_SecGAPpkg_automgrp ${LANG_ENGLISH} "Automata groups"
LangString DESC_SecGAPpkg_autpgrp ${LANG_ENGLISH} "Computing the Automorphism Group of a p-Group"
LangString DESC_SecGAPpkg_browse ${LANG_ENGLISH} "browsing applications and ncurses interface"
LangString DESC_SecGAPpkg_cap ${LANG_ENGLISH} "Categories, Algorithms, Programming"
LangString DESC_SecGAPpkg_carat ${LANG_ENGLISH} "Interface to CARAT, a crystallographic groups package"
LangString DESC_SecGAPpkg_circle ${LANG_ENGLISH} "Adjoint groups of finite rings"
LangString DESC_SecGAPpkg_cohomolo ${LANG_ENGLISH} "Cohomology groups of finite groups on finite modules"
LangString DESC_SecGAPpkg_congruence ${LANG_ENGLISH} "Congruence subgroups of SL(2,Integers)"
LangString DESC_SecGAPpkg_convex ${LANG_ENGLISH} "A package for fan combinatorics"
LangString DESC_SecGAPpkg_corelg ${LANG_ENGLISH} "computation with real Lie groups"
LangString DESC_SecGAPpkg_crime ${LANG_ENGLISH} "A GAP Package to Calculate Group Cohomology and Massey Products"
LangString DESC_SecGAPpkg_crisp ${LANG_ENGLISH} "Computing with Radicals, Injectors, Schunck classes and Projectors"
LangString DESC_SecGAPpkg_crypting ${LANG_ENGLISH} "Hashes and Crypto in GAP"
LangString DESC_SecGAPpkg_cryst ${LANG_ENGLISH} "Computing with crystallographic groups"
LangString DESC_SecGAPpkg_crystcat ${LANG_ENGLISH} "The crystallographic groups catalog"
LangString DESC_SecGAPpkg_ctbllib ${LANG_ENGLISH} "The GAP Character Table Library"
LangString DESC_SecGAPpkg_cubefree ${LANG_ENGLISH} "Constructing the Groups of a Given Cubefree Order"
LangString DESC_SecGAPpkg_curlinterface ${LANG_ENGLISH} "Simple Web Access"
LangString DESC_SecGAPpkg_cvec ${LANG_ENGLISH} "Compact vectors over finite fields"
LangString DESC_SecGAPpkg_datastructures ${LANG_ENGLISH} "Collection of standard data structures for GAP"
LangString DESC_SecGAPpkg_deepthought ${LANG_ENGLISH} "This package provides functions for computations in finitely generated nilpotent groups based on the Deep Thought algorithm."
LangString DESC_SecGAPpkg_design ${LANG_ENGLISH} "The Design Package for GAP"
LangString DESC_SecGAPpkg_digraphs ${LANG_ENGLISH} "Graphs, digraphs, and multidigraphs in GAP"
LangString DESC_SecGAPpkg_edim ${LANG_ENGLISH} "Elementary Divisors of Integer Matrices"
LangString DESC_SecGAPpkg_example ${LANG_ENGLISH} "Example/Template of a GAP Package"
LangString DESC_SecGAPpkg_examplesforhomalg ${LANG_ENGLISH} "Examples for the GAP Package homalg"
LangString DESC_SecGAPpkg_factint ${LANG_ENGLISH} "Advanced Methods for Factoring Integers"
LangString DESC_SecGAPpkg_fga ${LANG_ENGLISH} "Free Group Algorithms"
LangString DESC_SecGAPpkg_fining ${LANG_ENGLISH} "Finite Incidence Geometry"
LangString DESC_SecGAPpkg_float ${LANG_ENGLISH} "Integration of mpfr, mpfi, mpc, fplll and cxsc in GAP"
LangString DESC_SecGAPpkg_format ${LANG_ENGLISH} "Computing with formations of finite solvable groups."
LangString DESC_SecGAPpkg_forms ${LANG_ENGLISH} "Sesquilinear and Quadratic"
LangString DESC_SecGAPpkg_fplsa ${LANG_ENGLISH} "Finitely Presented Lie Algebras"
LangString DESC_SecGAPpkg_fr ${LANG_ENGLISH} "Computations with functionally recursive groups"
LangString DESC_SecGAPpkg_francy ${LANG_ENGLISH} "Framework for Interactive Discrete Mathematics"
LangString DESC_SecGAPpkg_fwtree ${LANG_ENGLISH} "Computing trees related to some pro-p-groups of finite width"
LangString DESC_SecGAPpkg_gapdoc ${LANG_ENGLISH} "A Meta Package for GAP Documentation"
LangString DESC_SecGAPpkg_gauss ${LANG_ENGLISH} "Extended Gauss functionality for GAP"
LangString DESC_SecGAPpkg_gaussforhomalg ${LANG_ENGLISH} "Gauss functionality for the homalg project"
LangString DESC_SecGAPpkg_gbnp ${LANG_ENGLISH} "computing Gröbner bases of noncommutative polynomials"
LangString DESC_SecGAPpkg_generalizedmorphismsforcap ${LANG_ENGLISH} "Implementations of generalized morphisms for the CAP project"
LangString DESC_SecGAPpkg_genss ${LANG_ENGLISH} "Generic Schreier-Sims"
LangString DESC_SecGAPpkg_gradedmodules ${LANG_ENGLISH} "A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings"
LangString DESC_SecGAPpkg_gradedringforhomalg ${LANG_ENGLISH} "Endow Commutative Rings with an Abelian Grading"
LangString DESC_SecGAPpkg_grape ${LANG_ENGLISH} "GRaph Algorithms using PErmutation groups"
LangString DESC_SecGAPpkg_groupoids ${LANG_ENGLISH} "Calculations with finite groupoids and their homomorphisms"
LangString DESC_SecGAPpkg_grpconst ${LANG_ENGLISH} "Constructing the Groups of a Given Order"
LangString DESC_SecGAPpkg_guarana ${LANG_ENGLISH} "Applications of Lie methods for computations with infinite polycyclic groups"
LangString DESC_SecGAPpkg_guava ${LANG_ENGLISH} "a GAP package for computing with error-correcting codes"
LangString DESC_SecGAPpkg_hap ${LANG_ENGLISH} "Homological Algebra Programming"
LangString DESC_SecGAPpkg_hapcryst ${LANG_ENGLISH} "A HAP extension for crytallographic groups"
LangString DESC_SecGAPpkg_hecke ${LANG_ENGLISH} "Calculating decomposition matrices of Hecke algebras"
LangString DESC_SecGAPpkg_help ${LANG_ENGLISH} "Hertweck-Luthar-Passi method."
LangString DESC_SecGAPpkg_homalg ${LANG_ENGLISH} "A homological algebra meta-package for computable Abelian categories"
LangString DESC_SecGAPpkg_homalgtocas ${LANG_ENGLISH} "A window to the outer world"
LangString DESC_SecGAPpkg_idrel ${LANG_ENGLISH} "Identities among relations"
LangString DESC_SecGAPpkg_intpic ${LANG_ENGLISH} "A package for drawing integers"
LangString DESC_SecGAPpkg_io ${LANG_ENGLISH} "Bindings for low level C library I/O routines"
LangString DESC_SecGAPpkg_io_forhomalg ${LANG_ENGLISH} "IO capabilities for the homalg project"
LangString DESC_SecGAPpkg_irredsol ${LANG_ENGLISH} "A library of irreducible soluble linear groups over finite fields and of finite primivite soluble groups"
LangString DESC_SecGAPpkg_itc ${LANG_ENGLISH} "Interactive Todd-Coxeter"
LangString DESC_SecGAPpkg_json ${LANG_ENGLISH} "Reading and Writing JSON"
LangString DESC_SecGAPpkg_jupyterkernel ${LANG_ENGLISH} "Jupyter kernel written in GAP"
LangString DESC_SecGAPpkg_jupyterviz ${LANG_ENGLISH} "Visualization Tools for Jupyter and the GAP REPL"
LangString DESC_SecGAPpkg_kan ${LANG_ENGLISH} "including double coset rewriting systems"
LangString DESC_SecGAPpkg_kbmag ${LANG_ENGLISH} "Knuth-Bendix on Monoids and Automatic Groups"
LangString DESC_SecGAPpkg_laguna ${LANG_ENGLISH} "Lie AlGebras and UNits of group Algebras"
LangString DESC_SecGAPpkg_liealgdb ${LANG_ENGLISH} "A database of Lie algebras"
LangString DESC_SecGAPpkg_liepring ${LANG_ENGLISH} "Database and algorithms for Lie p-rings"
LangString DESC_SecGAPpkg_liering ${LANG_ENGLISH} "Computing with finitely presented Lie rings"
LangString DESC_SecGAPpkg_linearalgebraforcap ${LANG_ENGLISH} "Category of Matrices over a Field for CAP"
LangString DESC_SecGAPpkg_localizeringforhomalg ${LANG_ENGLISH} "A Package for Localization of Polynomial Rings"
LangString DESC_SecGAPpkg_loops ${LANG_ENGLISH} "Computing with quasigroups and loops in GAP"
LangString DESC_SecGAPpkg_lpres ${LANG_ENGLISH} "Nilpotent Quotients of L-Presented Groups"
LangString DESC_SecGAPpkg_majoranaalgebras ${LANG_ENGLISH} "A package for constructing Majorana algebras and representations"
LangString DESC_SecGAPpkg_mapclass ${LANG_ENGLISH} "A Package For Mapping Class Orbit Computation"
LangString DESC_SecGAPpkg_matgrp ${LANG_ENGLISH} "Matric Group Interface Routines"
LangString DESC_SecGAPpkg_matricesforhomalg ${LANG_ENGLISH} "Matrices for the homalg project"
LangString DESC_SecGAPpkg_modisom ${LANG_ENGLISH} "Computing automorphisms and checking isomorphisms for modular group algebras of finite p-groups"
LangString DESC_SecGAPpkg_modulepresentationsforcap ${LANG_ENGLISH} "Category R-pres for CAP"
LangString DESC_SecGAPpkg_modules ${LANG_ENGLISH} "A homalg based package for the Abelian category of finitely presented modules over computable rings"
LangString DESC_SecGAPpkg_monoidalcategories ${LANG_ENGLISH} "Monoidal and monoidal (co)closed categories"
LangString DESC_SecGAPpkg_nilmat ${LANG_ENGLISH} "Computing with nilpotent matrix groups"
LangString DESC_SecGAPpkg_normalizinterface ${LANG_ENGLISH} "GAP wrapper for Normaliz"
LangString DESC_SecGAPpkg_nq ${LANG_ENGLISH} "Nilpotent Quotients of Finitely Presented Groups"
LangString DESC_SecGAPpkg_numericalsgps ${LANG_ENGLISH} "A package for numerical semigroups"
LangString DESC_SecGAPpkg_openmath ${LANG_ENGLISH} "OpenMath functionality in GAP"
LangString DESC_SecGAPpkg_orb ${LANG_ENGLISH} "Methods to enumerate orbits"
LangString DESC_SecGAPpkg_packagemanager ${LANG_ENGLISH} "Easily download and install GAP packages"
LangString DESC_SecGAPpkg_patternclass ${LANG_ENGLISH} "A permutation pattern class package"
LangString DESC_SecGAPpkg_permut ${LANG_ENGLISH} "A package to deal with permutability in finite groups"
LangString DESC_SecGAPpkg_polenta ${LANG_ENGLISH} "Polycyclic presentations for matrix groups"
LangString DESC_SecGAPpkg_polycyclic ${LANG_ENGLISH} "Computation with polycyclic groups"
LangString DESC_SecGAPpkg_polymakeinterface ${LANG_ENGLISH} "A package to provide algorithms for fans and cones of polymake to other packages"
LangString DESC_SecGAPpkg_polymaking ${LANG_ENGLISH} "Interfacing the geometry software polymake"
LangString DESC_SecGAPpkg_primgrp ${LANG_ENGLISH} "GAP Primitive Permutation Groups Library"
LangString DESC_SecGAPpkg_profiling ${LANG_ENGLISH} "Line by line profiling and code coverage for GAP"
LangString DESC_SecGAPpkg_qpa ${LANG_ENGLISH} "Quivers and Path Algebras"
LangString DESC_SecGAPpkg_quagroup ${LANG_ENGLISH} "Computations with quantum groups"
LangString DESC_SecGAPpkg_radiroot ${LANG_ENGLISH} "Roots of a Polynomial as Radicals"
LangString DESC_SecGAPpkg_rcwa ${LANG_ENGLISH} "Residue-Class-Wise Affine Groups"
LangString DESC_SecGAPpkg_rds ${LANG_ENGLISH} "A package for searching relative difference sets"
LangString DESC_SecGAPpkg_recog ${LANG_ENGLISH} "A collection of group recognition methods"
LangString DESC_SecGAPpkg_repsn ${LANG_ENGLISH} "Constructing representations of finite groups"
LangString DESC_SecGAPpkg_resclasses ${LANG_ENGLISH} "Set-Theoretic Computations with Residue Classes"
LangString DESC_SecGAPpkg_ringsforhomalg ${LANG_ENGLISH} "Dictionaries of external rings"
LangString DESC_SecGAPpkg_sco ${LANG_ENGLISH} "SCO - Simplicial Cohomology of Orbifolds"
LangString DESC_SecGAPpkg_scscp ${LANG_ENGLISH} "Symbolic Computation Software Composability Protocol in GAP"
LangString DESC_SecGAPpkg_semigroups ${LANG_ENGLISH} "A package for semigroups and monoids"
LangString DESC_SecGAPpkg_sglppow ${LANG_ENGLISH} "Database of groups of prime-power order for some prime-powers"
LangString DESC_SecGAPpkg_sgpviz ${LANG_ENGLISH} "A package for semigroup visualization"
LangString DESC_SecGAPpkg_simpcomp ${LANG_ENGLISH} "A GAP toolbox for simplicial complexes"
LangString DESC_SecGAPpkg_singular ${LANG_ENGLISH} "A GAP interface to Singular"
LangString DESC_SecGAPpkg_sla ${LANG_ENGLISH} "Computing with simple Lie algebras"
LangString DESC_SecGAPpkg_smallgrp ${LANG_ENGLISH} "The GAP Small Groups Library"
LangString DESC_SecGAPpkg_smallsemi ${LANG_ENGLISH} "A library of small semigroups"
LangString DESC_SecGAPpkg_sonata ${LANG_ENGLISH} "System of nearrings and their applications"
LangString DESC_SecGAPpkg_sophus ${LANG_ENGLISH} "Computing in nilpotent Lie algebras"
LangString DESC_SecGAPpkg_spinsym ${LANG_ENGLISH} "Brauer tables of spin-symmetric groups"
LangString DESC_SecGAPpkg_symbcompcc ${LANG_ENGLISH} "Computing with parametrised presentations for p-groups of fixed coclass"
LangString DESC_SecGAPpkg_thelma ${LANG_ENGLISH} "A package on threshold elements"
LangString DESC_SecGAPpkg_tomlib ${LANG_ENGLISH} "The GAP Library of Tables of Marks"
LangString DESC_SecGAPpkg_toolsforhomalg ${LANG_ENGLISH} "Special methods and knowledge propagation tools"
LangString DESC_SecGAPpkg_toric ${LANG_ENGLISH} "toric varieties and some combinatorial geometry computations"
LangString DESC_SecGAPpkg_toricvarieties ${LANG_ENGLISH} "A package to handle toric varieties"
LangString DESC_SecGAPpkg_transgrp ${LANG_ENGLISH} "Transitive Groups Library"
LangString DESC_SecGAPpkg_unipot ${LANG_ENGLISH} "Computing with elements of unipotent subgroups of Chevalley groups"
LangString DESC_SecGAPpkg_unitlib ${LANG_ENGLISH} "Library of normalized unit groups of modular group algebras"
LangString DESC_SecGAPpkg_utils ${LANG_ENGLISH} "Utility functions in GAP"
LangString DESC_SecGAPpkg_uuid ${LANG_ENGLISH} "RFC 4122 UUIDs"
LangString DESC_SecGAPpkg_walrus ${LANG_ENGLISH} "A new approach to proving hyperbolicity"
LangString DESC_SecGAPpkg_wedderga ${LANG_ENGLISH} "Wedderburn Decomposition of Group Algebras"
LangString DESC_SecGAPpkg_xgap ${LANG_ENGLISH} "a graphical user interface for GAP"
LangString DESC_SecGAPpkg_xmod ${LANG_ENGLISH} "Crossed Modules and Cat1-Groups"
LangString DESC_SecGAPpkg_xmodalg ${LANG_ENGLISH} "Crossed Modules and Cat1-Algebras"
LangString DESC_SecGAPpkg_yangbaxter ${LANG_ENGLISH} "Combinatorial Solutions for the Yang-Baxter equation"
LangString DESC_SecGAPpkg_zeromqinterface ${LANG_ENGLISH} "ZeroMQ bindings for GAP"

# Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPcore} $(DESC_SecGAPcore)

!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkgsNeeded} $(DESC_SecGAPpkgsNeeded)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkgsDefault} $(DESC_SecGAPpkgsDefault)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkgsSpecial} $(DESC_SecGAPpkgsSpecial)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkgsNoWindows} $(DESC_SecGAPpkgsNoWindows)

!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_4ti2interface} $(DESC_SecGAPpkg_4ti2interface)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_ace} $(DESC_SecGAPpkg_ace)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_aclib} $(DESC_SecGAPpkg_aclib)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_alnuth} $(DESC_SecGAPpkg_alnuth)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_anupq} $(DESC_SecGAPpkg_anupq)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_atlasrep} $(DESC_SecGAPpkg_atlasrep)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_autodoc} $(DESC_SecGAPpkg_autodoc)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_automata} $(DESC_SecGAPpkg_automata)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_automgrp} $(DESC_SecGAPpkg_automgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_autpgrp} $(DESC_SecGAPpkg_autpgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_browse} $(DESC_SecGAPpkg_browse)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_cap} $(DESC_SecGAPpkg_cap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_carat} $(DESC_SecGAPpkg_carat)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_circle} $(DESC_SecGAPpkg_circle)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_cohomolo} $(DESC_SecGAPpkg_cohomolo)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_congruence} $(DESC_SecGAPpkg_congruence)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_convex} $(DESC_SecGAPpkg_convex)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_corelg} $(DESC_SecGAPpkg_corelg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_crime} $(DESC_SecGAPpkg_crime)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_crisp} $(DESC_SecGAPpkg_crisp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_crypting} $(DESC_SecGAPpkg_crypting)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_cryst} $(DESC_SecGAPpkg_cryst)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_crystcat} $(DESC_SecGAPpkg_crystcat)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_ctbllib} $(DESC_SecGAPpkg_ctbllib)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_cubefree} $(DESC_SecGAPpkg_cubefree)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_curlinterface} $(DESC_SecGAPpkg_curlinterface)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_cvec} $(DESC_SecGAPpkg_cvec)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_datastructures} $(DESC_SecGAPpkg_datastructures)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_deepthought} $(DESC_SecGAPpkg_deepthought)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_design} $(DESC_SecGAPpkg_design)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_digraphs} $(DESC_SecGAPpkg_digraphs)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_edim} $(DESC_SecGAPpkg_edim)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_example} $(DESC_SecGAPpkg_example)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_examplesforhomalg} $(DESC_SecGAPpkg_examplesforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_factint} $(DESC_SecGAPpkg_factint)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_fga} $(DESC_SecGAPpkg_fga)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_fining} $(DESC_SecGAPpkg_fining)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_float} $(DESC_SecGAPpkg_float)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_format} $(DESC_SecGAPpkg_format)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_forms} $(DESC_SecGAPpkg_forms)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_fplsa} $(DESC_SecGAPpkg_fplsa)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_fr} $(DESC_SecGAPpkg_fr)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_francy} $(DESC_SecGAPpkg_francy)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_fwtree} $(DESC_SecGAPpkg_fwtree)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gapdoc} $(DESC_SecGAPpkg_gapdoc)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gauss} $(DESC_SecGAPpkg_gauss)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gaussforhomalg} $(DESC_SecGAPpkg_gaussforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gbnp} $(DESC_SecGAPpkg_gbnp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_generalizedmorphismsforcap} $(DESC_SecGAPpkg_generalizedmorphismsforcap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_genss} $(DESC_SecGAPpkg_genss)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gradedmodules} $(DESC_SecGAPpkg_gradedmodules)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_gradedringforhomalg} $(DESC_SecGAPpkg_gradedringforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_grape} $(DESC_SecGAPpkg_grape)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_groupoids} $(DESC_SecGAPpkg_groupoids)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_grpconst} $(DESC_SecGAPpkg_grpconst)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_guarana} $(DESC_SecGAPpkg_guarana)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_guava} $(DESC_SecGAPpkg_guava)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_hap} $(DESC_SecGAPpkg_hap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_hapcryst} $(DESC_SecGAPpkg_hapcryst)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_hecke} $(DESC_SecGAPpkg_hecke)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_help} $(DESC_SecGAPpkg_help)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_homalg} $(DESC_SecGAPpkg_homalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_homalgtocas} $(DESC_SecGAPpkg_homalgtocas)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_idrel} $(DESC_SecGAPpkg_idrel)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_intpic} $(DESC_SecGAPpkg_intpic)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_io} $(DESC_SecGAPpkg_io)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_io_forhomalg} $(DESC_SecGAPpkg_io_forhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_irredsol} $(DESC_SecGAPpkg_irredsol)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_itc} $(DESC_SecGAPpkg_itc)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_json} $(DESC_SecGAPpkg_json)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_jupyterkernel} $(DESC_SecGAPpkg_jupyterkernel)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_jupyterviz} $(DESC_SecGAPpkg_jupyterviz)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_kan} $(DESC_SecGAPpkg_kan)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_kbmag} $(DESC_SecGAPpkg_kbmag)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_laguna} $(DESC_SecGAPpkg_laguna)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_liealgdb} $(DESC_SecGAPpkg_liealgdb)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_liepring} $(DESC_SecGAPpkg_liepring)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_liering} $(DESC_SecGAPpkg_liering)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_linearalgebraforcap} $(DESC_SecGAPpkg_linearalgebraforcap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_localizeringforhomalg} $(DESC_SecGAPpkg_localizeringforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_loops} $(DESC_SecGAPpkg_loops)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_lpres} $(DESC_SecGAPpkg_lpres)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_majoranaalgebras} $(DESC_SecGAPpkg_majoranaalgebras)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_mapclass} $(DESC_SecGAPpkg_mapclass)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_matgrp} $(DESC_SecGAPpkg_matgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_matricesforhomalg} $(DESC_SecGAPpkg_matricesforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_modisom} $(DESC_SecGAPpkg_modisom)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_modulepresentationsforcap} $(DESC_SecGAPpkg_modulepresentationsforcap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_modules} $(DESC_SecGAPpkg_modules)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_monoidalcategories} $(DESC_SecGAPpkg_monoidalcategories)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_nilmat} $(DESC_SecGAPpkg_nilmat)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_normalizinterface} $(DESC_SecGAPpkg_normalizinterface)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_nq} $(DESC_SecGAPpkg_nq)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_numericalsgps} $(DESC_SecGAPpkg_numericalsgps)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_openmath} $(DESC_SecGAPpkg_openmath)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_orb} $(DESC_SecGAPpkg_orb)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_packagemanager} $(DESC_SecGAPpkg_packagemanager)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_patternclass} $(DESC_SecGAPpkg_patternclass)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_permut} $(DESC_SecGAPpkg_permut)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_polenta} $(DESC_SecGAPpkg_polenta)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_polycyclic} $(DESC_SecGAPpkg_polycyclic)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_polymakeinterface} $(DESC_SecGAPpkg_polymakeinterface)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_polymaking} $(DESC_SecGAPpkg_polymaking)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_primgrp} $(DESC_SecGAPpkg_primgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_profiling} $(DESC_SecGAPpkg_profiling)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_qpa} $(DESC_SecGAPpkg_qpa)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_quagroup} $(DESC_SecGAPpkg_quagroup)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_radiroot} $(DESC_SecGAPpkg_radiroot)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_rcwa} $(DESC_SecGAPpkg_rcwa)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_rds} $(DESC_SecGAPpkg_rds)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_recog} $(DESC_SecGAPpkg_recog)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_repsn} $(DESC_SecGAPpkg_repsn)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_resclasses} $(DESC_SecGAPpkg_resclasses)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_ringsforhomalg} $(DESC_SecGAPpkg_ringsforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sco} $(DESC_SecGAPpkg_sco)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_scscp} $(DESC_SecGAPpkg_scscp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_semigroups} $(DESC_SecGAPpkg_semigroups)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sglppow} $(DESC_SecGAPpkg_sglppow)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sgpviz} $(DESC_SecGAPpkg_sgpviz)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_simpcomp} $(DESC_SecGAPpkg_simpcomp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_singular} $(DESC_SecGAPpkg_singular)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sla} $(DESC_SecGAPpkg_sla)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_smallgrp} $(DESC_SecGAPpkg_smallgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_smallsemi} $(DESC_SecGAPpkg_smallsemi)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sonata} $(DESC_SecGAPpkg_sonata)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_sophus} $(DESC_SecGAPpkg_sophus)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_spinsym} $(DESC_SecGAPpkg_spinsym)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_symbcompcc} $(DESC_SecGAPpkg_symbcompcc)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_thelma} $(DESC_SecGAPpkg_thelma)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_tomlib} $(DESC_SecGAPpkg_tomlib)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_toolsforhomalg} $(DESC_SecGAPpkg_toolsforhomalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_toric} $(DESC_SecGAPpkg_toric)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_toricvarieties} $(DESC_SecGAPpkg_toricvarieties)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_transgrp} $(DESC_SecGAPpkg_transgrp)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_unipot} $(DESC_SecGAPpkg_unipot)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_unitlib} $(DESC_SecGAPpkg_unitlib)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_utils} $(DESC_SecGAPpkg_utils)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_uuid} $(DESC_SecGAPpkg_uuid)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_walrus} $(DESC_SecGAPpkg_walrus)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_wedderga} $(DESC_SecGAPpkg_wedderga)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_xgap} $(DESC_SecGAPpkg_xgap)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_xmod} $(DESC_SecGAPpkg_xmod)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_xmodalg} $(DESC_SecGAPpkg_xmodalg)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_yangbaxter} $(DESC_SecGAPpkg_yangbaxter)
!insertmacro MUI_DESCRIPTION_TEXT ${SecGAPpkg_zeromqinterface} $(DESC_SecGAPpkg_zeromqinterface)

!insertmacro MUI_FUNCTION_DESCRIPTION_END


#######################################################################
#
# Make impossible installing special packages without default packages
#
Function .onInit
 
  # This is necessary otherwise Sec3 won't be selectable for the first time you click it.
  SectionGetFlags ${SecGAPpkgsDefault} $R0
  IntOp $R0 $R0 & ${SF_SELECTED}
  StrCpy $IndependentSectionState $R0
 
FunctionEnd
 
Function .onSelChange
Push $R0
Push $R1
 
  # Check if SecGAPpkgsDefault was just selected then select SecGAPpkgsSpecial
  SectionGetFlags ${SecGAPpkgsDefault} $R0
  IntOp $R0 $R0 & ${SF_SELECTED}
  StrCmp $R0 $IndependentSectionState +3
    StrCpy $IndependentSectionState $R0
  Goto UnselectDependentSections
    StrCpy $IndependentSectionState $R0
 
  Goto CheckDependentSections
 
  # Select SecGAPpkgsDefault if SecGAPpkgsSpecial was selected.
  SelectIndependentSection:
 
    SectionGetFlags ${SecGAPpkgsDefault} $R0
    IntOp $R1 $R0 & ${SF_SELECTED}
    StrCmp $R1 ${SF_SELECTED} +3
 
    IntOp $R0 $R0 | ${SF_SELECTED}
    SectionSetFlags ${SecGAPpkgsDefault} $R0
 
    StrCpy $IndependentSectionState ${SF_SELECTED}
 
  Goto End
 
  # Were SecGAPpkgsSpecial just unselected?
  CheckDependentSections:
 
  SectionGetFlags ${SecGAPpkgsSpecial} $R0
  IntOp $R0 $R0 & ${SF_SELECTED}
  StrCmp $R0 ${SF_SELECTED} SelectIndependentSection
  
  Goto End
 
  # Unselect SecGAPpkgsSpecial if SecGAPpkgsDefault was unselected.
  UnselectDependentSections:
 
    SectionGetFlags ${SecGAPpkgsSpecial} $R0
    IntOp $R1 $R0 & ${SF_SELECTED}
    StrCmp $R1 ${SF_SELECTED} 0 +3
 
    IntOp $R0 $R0 ^ ${SF_SELECTED}
    SectionSetFlags ${SecGAPpkgsSpecial} $R0
 
  End:
 
Pop $R1
Pop $R0
FunctionEnd


#######################################################################
#
# Uninstaller Section
#
Section "Uninstall"

  RMDir /r "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
  Delete "$SMPROGRAMS\$StartMenuFolder\*.*"
  RMDir /r "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\GAP"

SectionEnd
