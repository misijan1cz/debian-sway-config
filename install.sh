#!/bin/bash

username="mj"

# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi

# Change to Debian Sid branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list

# Copy config files
mkdir -p /home/$username/.config
mkdir -p /home/$username/.local
mkdir -p /home/$username/.swaylock
cp -r dotconfig/* /home/$username/.config/
cp -r dotlocal/* /home/$username/.local/
cp -r dotswaylock/* /home/$username/.swaylock/
cp dotvimrc /home/$username/.vimrc

# Get all necessary packages
apt update
apt upgrade -y
apt install -y vim curl wget git htop # chores

apt install -y xwayland sway swaybg swayidle waybar # Sway
apt install -y kitty wofi mc grimshot nautilus light wdisplays xdg-desktop-portal-wlr lm-sensors firefox # Sway apps
apt install -y libxkbcommon-x11-0 libcairo2 libpam0g # swaylock-effects runtime deps
apt install -y meson wayland-protocols # swaylock-effects compiletime deps
apt install -y python3-i3ipc # autotiling
apt install -y fontconfig

apt install -y network-manager # NetworkManager
apt install -y pipewire{,-pulse,-alsa,-jack,-audio} libspa-0.2-bluetooth wireplumber pavucontrol # pipewire
apt install -y python3-{pip,dbus} # eduroam
apt install -y virt-manager qemu-{utils,system-x86,system-gui} libspice-server1 # QEMU virtualisation
apt install -y make gcc libpam0g-dev libxcb1-dev # ly


# Build Swaylock-effects
git clone https://github.com/mortie/swaylock-effects
cd swaylock-effects
meson build
ninja -C build
ninja -C build install
#chmod a+s /usr/local/bin/swaylock # for system without PAM
cd ..


# Get autotiling
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py autotiling
chmod +x autotiling
cp autotiling /bin


# Build ly
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd
cd ..


# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh


# Enable services
systemctl enable --now NetworkManager
systemctl enable --now libvirtd 	# QEMU virtualisation
systemctl enable ly 			# ly ("animate" at /etc/ly/config.ini)
systemctl disable getty@tty2.service	# ly to work
systemctl enable tailscaled		# already active, but whatever


# Update fonts
fc-cache -vf

# Configure eduroam
pip3 install distro
curl 'https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=1070&device=linux&generatedfor=user&openroaming=0' > eduroam-Charles-University.py
python3 eduroam-Charles-University.py


# Change target to GUI
systemctl set-default graphical.target


# Final notes
echo "To install bluetuith go to releases https://github.com/darkhz/bluetuith/releases."
echo "To set up tailscale run 'tailcale up'."


echo "DONE"
# THE END
