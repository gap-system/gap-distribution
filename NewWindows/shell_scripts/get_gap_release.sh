#!/usr/bin/env bash
set -eux
mkdir --parents /opt/
cd /opt
wget https://www.gap-system.org/pub/gap/gap-4.11/tar.gz/gap-4.11.0.tar.gz
tar -xf gap-4.11.0.tar.gz
rm gap-4.11.0.tar.gz
# Have standard directory name
mv gap-* gap