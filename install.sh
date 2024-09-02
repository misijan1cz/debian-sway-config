#!/bin/bash

# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


username=$(id -u -n 1000)
maindir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# ---------------------------------------------
#                 INSTALLATION
# ---------------------------------------------


# Change to Debian Sid branch
#bash $maindir/scripts/debian_branch_sid.sh


# Get all necessary packages
apt update
apt upgrade -y
apt install -y vim
apt install -y git gh curl wget imv firefox		# user-defined programs
apt install -y build-essential vim git cscope libncurses-dev libssl-dev bison flex bc libelf-dev git-email # user-defined programs (dev)

apt install -y xwayland sway{,bg,idle} waybar foot	# Sway
apt install -y wmenu mc grimshot thunar light wdisplays xdg-desktop-portal-wlr lm-sensors mako-notifier playerctl mate-polkit # preconfigured Sway tools (optional)
apt install -y nvim ripgrep				# neovim
apt install -y python3-i3ipc 			# autotiling
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

#Project specific:
## COMPASS WTSA
apt install -y opencl-headers ocl-icd-opencl-dev
apt install -y intel-opencl-icd				#intel igpu opencl driver


# ---------------------------------------------
#                CONFIGURATION
# ---------------------------------------------

# Copy dotfiles
bash $maindir/scripts/my_dotfiles				# git (residual left on purpose)

# Configure the rest
bash $maindir/scripts/config_NetworkManager.sh	# (sudo)
bash $maindir/scripts/config_systemd.sh			# ufw, powerprofiles, fc-cache (sudo)
bash $maindir/scripts/get_tailscale.sh			# curl (sudo)
bash $maindir/scripts/get_ly.sh					# make, git (sudo)
bash $maindir/scripts/get_sway_save_outputs.sh	# git (UID)
bash $maindir/scripts/get_autotiling.sh			# wget (sudo, py)
bash $maindir/scripts/get_eduroam.sh			# curl (sudo, py)
bash $maindir/scripts/get_ollama.sh				# curl
#bash $maindir/scripts/get_swaylock_effects.sh	# meson, ninja, git

# Cleanup
rm -rf $maindir/builds
bash $maindir/postinstall.sh

echo "DONE"
# THE END
