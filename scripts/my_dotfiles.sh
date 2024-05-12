#!/bin/bash

username=$(id -u -n 1000)
returndir=$(pwd)


# Copy configuration
cd /home/$username
git clone https://github.com/misijan1cz/dotfiles
bash dotfiles/install.sh
cd $returndir
