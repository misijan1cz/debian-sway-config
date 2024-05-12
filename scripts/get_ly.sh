#!/bin/bash


# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


# Build ly
mkdir builds
cd builds
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
cd ../..
rm -rf builds


# Enable service
systemctl enable ly

# change "animate" at /etc/ly/config.ini
