# debian-sway-config

Functional Debian Sway desktop configuration.   
Tested on **Debian 12 (bookworm)**.

## Usage

- Create (almost) minimal installation of Debian stable.
  - run Debian NetInstall image
  - when selecting packages, uncheck "Desktop enviroment" and "GNOME" (leave only "Essential packages" checked)
  - finish installation
- Install git: `sudo apt install git`
- Clone branch: `git clone https://github.com/misijan1cz/debian-sway-config`
- Go to the cloned directory: `cd debian-sway-config`
- Run install script as root: `sudo su` and `./install.sh`

## Reminder

This repository is for my personal use but feel free to clone it.   
Keyboard layout is cz (qwerty) by default. You can change it in `.config/sway/config` file.

This repository only contains *dotfiles* and other files for quick post-install configuration on **Debian**.   
This repository is **not a distribution**.