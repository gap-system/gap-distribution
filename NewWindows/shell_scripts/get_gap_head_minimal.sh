#!/usr/bin/env bash
set -eux
mkdir --parents /opt/
cd /opt/
if [ -d gap ]; then
    (cd gap; git pull)
else
    git clone https://www.github.com/gap-system/gap gap --depth=1
fi;
cd gap
./autogen.sh
# Have to run configure so bootstrap-pkg-full works
./configure
# Clean out old package directory, if it exists
rm -rf pkg
make bootstrap-pkg-minimal
