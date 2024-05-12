#!/bin/bash

# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


username=$(id -u -n 1000)


# Enable services
ufw enable					# firewall
systemctl enable libvirtd 			# QEMU virtualization
systemctl disable getty@tty2.service
systemctl enable bluetooth			# bluetooth
systemctl enable --now power-profiles-daemon 	# power profiles


# Add user to groups
usermod -a -G libvirt $username			# QEMU virtualization


# Give user ownership of all dirs in home
chown -R $username:$username /home/$username


# Set power-saver profile
powerprofilesctl set power-saver


# Update fonts
fc-cache -vf


# Set time zone
timedatectl set-timezone Europe/Prague


# Change target to GUI
systemctl set-default graphical.target


