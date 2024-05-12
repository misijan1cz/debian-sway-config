#!/bin/bash

username=$(id -u -n 1000)

mkdir builds
cd builds
git clone https://github.com/nwg-piotr/sway-save-outputs
cd sway-save-outputs
bash install.sh
cp sway_save_outputs /home/$username/.local/bin/sway_save_outputs
cd ../..
rm -rf builds
