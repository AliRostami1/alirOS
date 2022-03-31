#! /usr/sh

# This file is meant to run first

# Make it so the script will exit on 
# command failure
set -e

# Install all packages in pkglist.txt
sudo pacman -S - < pkglist.txt

# Install all packages in aurlist.txt
yay -S - < aurlist.txt

# Run post-install.sh
./post-install.sh
