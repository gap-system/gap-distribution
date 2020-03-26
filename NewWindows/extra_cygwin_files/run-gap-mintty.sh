#!/usr/bin/env bash

cd ~

/opt/gap/gap


if [ $? -ne 0 ]; then
    read -p "GAP exited with an error. Press Enter to close window"
fi