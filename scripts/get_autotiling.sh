#!/bin/bash


# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


# Get autotiling
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py /usr/bin/autotiling
chmod +x /usr/bin/autotiling
