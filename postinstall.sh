#!/bin/bash

echo -e "\n#############\nMANUAL UPDATE\n#############\n"
echo -e "Bluetuith version attached in /home/<user>/.local/bin may be outdated. You can download the last release from https://github.com/darkhz/bluetuith/releases."
echo -e "Default VM is configured as 'OriginLab' in QEMU USER SESSION.\nFor Windows machines remember to run 'WinSAT formal' to detect SSD and disable defragmentation/trim optimisation."

echo -e "\n#############\nOTHER\n#############\n"
echo -e "It might be necessary to edit .config/user-dirs.dirs and use 'xdg-user-dirs-update' a few times..."
echo -e "In Firefox about:config you may edit:\n\t. pdfjs.scrollModeOnLoad to 2 (wrapped)\n\t. full-screen-api.ignore-widgets to true (fullscreen->fullwindow)."

echo -e "\n###########\nPOSTINSTALL\n###########\n"
echo -e "To set up eduroam run 'python3 ~/eduroam-cuni.py'"
echo -e "To set up tailscale run 'tailcale up'."
echo -e "To set up screen sharing edit '/usr/share/wayland-sessions/sway.desktop' to exec 'env XDG_CURRENT_DESKTOP=sway dbus-run-session sway'"
echo -e "(xdpw checklist: https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist)"
echo -e "\nTo see this reminder again, run ./postinstall.sh script in this directory."
