This directory contains scripts which automatically build GAP on Cygwin.

Producing an installer requires Inno Setup 6 ( https://jrsoftware.org/isdl.php#stable ) is installed in it's standard location.


Short version: Run 'build_gap_release.bat', and eventually an installer will appear in a directory called 'Output'.


Description of scripts
----------------------

This script runs a series of smaller scripts:

cygwin_install.bat: Install two copies of cygwin
 - cygwin_build_gap : For building GAP (includes compilers and dev versions of packages)
 - cygwin_release_gap : A smaller Cygwin which only includes files needed for running GAP.


run_script_in_cygwin.bat : Take a shell script as an argument and runs it inside cygwin_build_gap. The scripts available are:

- get_gap_head.sh : Get GAP master branch
- get_gap_head_minima.sh : Get GAP master branch with minimal packages (smallest)
- get_gap_release.sh : Get GAP release (current hard-wired to 4.11)
- build_gap_and_packages.sh : Build whatever GAP we previously grabbed.

step_move_gap_to_release.bat : Move GAP from the cygwin_build_gap to cygwin_release_gap, doing some cleanup and adding extra files (these extra files are described below)


Cygwin changes / customisations
-------------------------------

Some files inside the Cygwin install are changed/customised. These are described below:


gap.bat - Run GAP in the standard windows terminal. This is not put on the start menu, and is provided for non-interactive use.

gap-mintty.bat - Run GAP in the 'mintty' terminal. This tries to provide the best user experience, including keeping the window open if GAP exits with an error.

run-gap.sh - Run by gap.bat
run-mintty-gap.sh - Run by gap-mintty.bat

etc/nsswitch.conf - Sets the 'home' directory to the User's Windows home directory.
etc/fstab - Set the /tmp directory to the User's Windows temp directory
