#!/bin/bash


# Build Swaylock-effects
mkdir builds
cd builds
git clone https://github.com/mortie/swaylock-effects
cd swaylock-effects
meson setup build
ninja -C build
ninja -C build install
#chmod a+s /usr/local/bin/swaylock # for system without PAM
cd ../..
rm -rf builds
