set TERMINFO=/proc/cygdrive/c/Users/jenkins/workspace/GAP-dev-windows-test/GAP-git-snapshot/terminfo
set CYGWIN=nodosfilewarning
set LANG=en_US.UTF-8
set HOME=%HOMEDRIVE%%HOMEPATH%
set PATH=C:\Users\jenkins\workspace\GAP-dev-windows-test\GAP-git-snapshot\bin\i686-pc-cygwin-gcc-default32;%PATH%
cd %HOME%
C:\Users\jenkins\workspace\GAP-dev-windows-test\GAP-git-snapshot\bin\i686-pc-cygwin-gcc-default32\gap.exe -l /proc/cygdrive/C/Users/jenkins/workspace/GAP-dev-windows-test/GAP-git-snapshot %*
