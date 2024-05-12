# debian-sway-config

Debian Sway desktop configuration.   
Last tested on **Debian unstable (trixie/sid)** on 21.10.2023.

## Usage

- Create minimal installation of Debian stable.
  - run Debian NetInstall image
  - when selecting packages, uncheck "Desktop enviroment" and "GNOME" (leave only "Essential packages" checked)
  - finish installation
- Install git: `sudo apt install git`
- Clone branch: `git clone https://github.com/misijan1cz/debian-sway-config`
- Go to the cloned directory: `cd debian-sway-config`
- Change used username in `install.sh`
- Run install script as root: `sudo su` and `bash install.sh`

## Reminder

This repository is for my personal use but feel free to clone it.
Script *scripts/my_dotfiles.sh* pulls my personal dotfiles repo.
  

This repository only contains scripts for quick post-install configuration on **Debian**.   
This repository is **not a distribution**.

## Thanks

- darkhz (bluetuith): https://github.com/darkhz/bluetuith
- piotr (sway-save-outputs): https://github.com/nwg-piotr/sway-save-outputs
- open-source community. It's amazing to have you around.
