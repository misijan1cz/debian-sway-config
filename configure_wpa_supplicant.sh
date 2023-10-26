#! /bin/bash

# Corect wpa_supplicant conflict previous session
netiface=$(printf '%s\n' /sys/class/net/*/wireless | cut -d/ -f5)
maindir=$(dirname $0)
if [[ -n "$netiface" ]]; then
	cp $maindir/configs/wpa_supplicant.conf /etc/wpa_supplicant.conf
	echo -e "pre-up sudo wpa_supplicant -B -i$netiface -c/etc/wpa_supplicant.conf -Dnl80211 \npost-down sudo killall -q wpa_supplicant" >> /etc/network/interfaces
else
	echo "Could not find wireless interface."
fi
