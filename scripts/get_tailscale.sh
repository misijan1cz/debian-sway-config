#!/bin/bash


# Check for ROOT user
if [[ $EUID -ne 0 ]]; then
	echo "Run me as root, please." 2>&1
	exit 1
fi


# Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Enable service (already active, but whatever)
systemctl enable tailscaled
