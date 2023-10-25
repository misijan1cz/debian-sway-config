#!/bin/bash
echo -e "\n###########\nPOSTINSTALL\n###########\n"
echo -e "To set up eduroam run 'python3 ~/eduroam-cuni.py'"
echo -e "To set up tailscale run 'tailcale up'."
echo -e "\n#############\nMANUAL UPDATE\n#############\n"
echo -e "Bluetuith version attached in /home/<user>/.local/bin may be outdated. You can download the last release from https://github.com/darkhz/bluetuith/releases."
echo -e "Default VM is configured as 'OriginLab' in QEMU USER SESSION"
echo -e "It might be necessary to edit .config/user-dirs.dirs and use 'xdg-user-dirs-update' a few times..."
echo -e "\n To see this reminder again, run ./postinstall.sh script in this directory."
