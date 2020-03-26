#!/usr/bin/env bash
set -eux

cd /opt/gap

./configure
make -j4
(cd pkg && ../bin/BuildPackages.sh)