#!/bin/bash

# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


username=$(id -u -n 1000)
maindir=$(dirname $0)


# Change to Debian Sid branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp $maindir/configs/sources.list /etc/apt/sources.list


# For the purposes of this script
mkdir -p $maindir/builds


# Copy config files
mkdir -p /home/$username/.config
mkdir -p /home/$username/.local
mkdir -p /home/$username/.swaylock
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Documents
mkdir -p /home/$username/Music
mkdir -p /home/$username/Videos
cp -r $maindir/dotconfig/* /home/$username/.config/
cp -r $maindir/dotlocal/* /home/$username/.local/
cp -r $maindir/dotswaylock/* /home/$username/.swaylock/
cp $maindir/configs/dotvimrc /home/$username/.vimrc


# Get all necessary packages
apt update
apt upgrade -y
apt install -y vim
apt install -y git gh curl wget 			# user-defined programs

apt install -y xwayland sway{,bg,idle} waybar foot	# Sway
apt install -y wofi mc grimshot nautilus light wdisplays xdg-desktop-portal-wlr lm-sensors firefox mako-notifier # preconfigured Sway apps (optional)
apt install -y python3-i3ipc 				# autotiling
apt install -y fontconfig 				# additional fonts

apt install -y swaylock 				# swaylock (OR swaylock-effects)
#apt install -y libxkbcommon-x11-0 libcairo2 libpam0g 	# swaylock-effects runtime deps
#apt install -y meson wayland-protocols 		# swaylock-effects compiletime deps
# WARNING: swaylock-effects is dependent on wayland-client.h library. Not found in Sid on 20.10.2023. :/

apt install -y network-manager bluetooth bluez{,-obexd}	# bluetooth and network
apt install -y ufw					# system security
apt install -y pipewire{,-pulse,-alsa,-jack,-audio} libspa-0.2-bluetooth wireplumber pavucontrol # audio (pipewire)
apt install -y python3-{pip,dbus} 			# eduroam
apt install -y power-profiles-daemon 			# Power Profiles
apt install -y virt-manager qemu-{utils,system-x86,system-gui} libspice-server1 # QEMU virtualisation
apt install -y make gcc libpam0g-dev libxcb1-dev 	# ly greeter dependencies
apt install -y python3-i3ipc				# sway-save-outputs runtime dependency


## Build Swaylock-effects
#cd $maindir/builds
#git clone https://github.com/mortie/swaylock-effects
#cd swaylock-effects
#meson setup build
#ninja -C build
#ninja -C build install
##chmod a+s /usr/local/bin/swaylock # for system without PAM
##cd $maindir


# Get autotiling
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py /usr/bin/autotiling
chmod +x /usr/bin/autotiling


# Build ly
cd $maindir/builds
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
cd $maindir


# Build sway-save-outputs
cd $maindir/builds
git clone https://github.com/nwg-piotr/sway-save-outputs
cd sway-save-outputs
bash install.sh
cp sway_save_outputs /home/$username/.local/bin/sway_save_outputs
#cd $maindir


# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh


# Set interfaces as managed by NetworkManager
mv /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.bak
cp $maindir/configs/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf


# Corect wpa_supplicant conflict previous session
netiface=$(printf '%s\n' /sys/class/net/*/wireless | cut -d/ -f5)
if [[ -n "$netiface" ]] &&  [[ "$(echo $netiface | wc -w)" -eq 1 ]]; then
	cp $maindir/configs/wpa_supplicant.conf /etc/wpa_supplicant.conf
	echo -e "pre-up sudo wpa_supplicant -B -i$netiface -c/etc/wpa_supplicant.conf -Dnl80211 \npost-down sudo killall -q wpa_supplicant" >> /etc/network/interfaces
	echo -e "\nDone configuring wpa_supplicant for use with NetworkManager.\n"
else
	echo -e "\nError: None or too many interfaces. Cannot configure wpa_supplicant.\n"
fi


# Enable services
systemctl disable wpa_supplicant		# NetworkManager
systemctl enable NetworkManager
ufw enable					# firewall
systemctl enable libvirtd 			# QEMU virtualization
systemctl enable ly 				# ly - login screen ("animate" at /etc/ly/config.ini)
systemctl disable getty@tty2.service
systemctl enable tailscaled			# tailscale - already active, but whatever
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


# Download eduroam config script
curl 'https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=1070&device=linux&generatedfor=user&openroaming=0' > /home/$username/eduroam-cuni.py


# Set time zone
timedatectl set-timezone Europe/Prague


# Change target to GUI
systemctl set-default graphical.target


# Cleanup
rm -r $maindir/builds
bash $maindir/postinstall.sh

echo "DONE"
# THE END
