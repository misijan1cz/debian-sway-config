#!/bin/bash


# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Change to Debian Sid branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp $script_dir/../files/sources.list /etc/apt/sources.list
