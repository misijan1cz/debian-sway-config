#!/bin/bash

# chores
dnf update
dnf install -y vim curl git # chores
dnf install -y kitty wofi mc grimshot nautilus light wdisplays xdg-desktop-portal-wlr lm_sensors # Sway apps
dnf install -y NetworkManager NetworkManager-tui # NetworkManager
dnf install -y pipewire{,-audio-client-libraries} libspa-0.2-bluetooth # pipewire
dnf install -y python3-{pip,dbus} # eduroam
dnf install -y qemu virt-manager spice-server # QEMU virtualisation
dnf install -y make gcc pam-devel libxcb-devel # ly


# change Fedora Sway spin defaults
dnf copr enable eddsalkield/swaylock-effects
rpm -e --nodeps swaylock
dnf install -y swaylock-effects

# install ly
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make install installsystemd

# install bluetuith

# eduroam - configure
pip3 install distro
curl 'https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=1070&device=linux&generatedfor=user&openroaming=0' > eduroam-Charles-University.py
python3 eduroam-Charles-University.py

# enable services
# ... NetworkManager (disable previous manager first)
#systemctl enable --now NetworkManager
# ... QEMU virtualisation
systemctl enable --now libvirtd 
# ... ly (uncomment "animate" at /etc/ly/config.ini and set to true)
systemctl disable gdm
systemctl disable sddm
systemctl disable lightdm
systemctl enable ly 
systemctl disable getty@tty2.service
