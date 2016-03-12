set TERMINFO=/proc/cygdrive/c/Users/jenkins/workspace/GAP-stable-windows-test64/GAP-git-stable-snapshot/terminfo
set CYGWIN=nodosfilewarning
set LANG=en_US.UTF-8
set HOME=%HOMEDRIVE%%HOMEPATH%
set PATH=C:\Users\jenkins\workspace\GAP-stable-windows-test64\GAP-git-stable-snapshot\bin\i686-pc-cygwin-gcc-default32;%PATH%
cd %HOME%
C:\Users\jenkins\workspace\GAP-stable-windows-test64\GAP-git-stable-snapshot\bin\x86_64-unknown-cygwin-gcc-default64\gap.exe -l /proc/cygdrive/C/Users/jenkins/workspace/GAP-stable-windows-test64/GAP-git-stable-snapshot %*
