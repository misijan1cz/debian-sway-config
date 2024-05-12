#!/bin/bash


# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


username=$(id -u -n 1000)
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Set interfaces as managed by NetworkManager
mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.bak
cp $script_dir/../files/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf


# Corect wpa_supplicant conflict previous session
netiface=$(printf '%s\n' /sys/class/net/*/wireless | cut -d/ -f5)
if [[ -n "$netiface" ]] &&  [[ "$(echo $netiface | wc -w)" -eq 1 ]]; then
	cp $script_dir/../files/wpa_supplicant.conf /etc/wpa_supplicant.conf
	echo -e "pre-up sudo wpa_supplicant -B -i$netiface -c/etc/wpa_supplicant.conf -Dnl80211 \npost-down sudo killall -q wpa_supplicant" >> /etc/network/interfaces
	echo -e "\nDone configuring wpa_supplicant for use with NetworkManager.\n"
else
	echo -e "\nError: None or too many interfaces. Cannot configure wpa_supplicant.\n"
fi


# Enable services
systemctl disable wpa_supplicant
systemctl enable NetworkManager
