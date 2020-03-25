#!/usr/bin/env bash
set -eux
mkdir --parents /opt/gap
cd /opt/gap
if [ -d gap-master ]; then
    (cd gap-master; git pull)
else
    git clone https://www.github.com/gap-system/gap gap-master --depth=1
fi;
cd gap-master
./autogen.sh
./configure
make -j4
# Clean out old package directory, if it exists
rm -rf pkg
make bootstrap-pkg-full
cd pkg
../bin/BuildPackages.sh