#! /bin/zsh

# This file is meant to run first

# Make it so the script will exit on 
# command failure
set -e

# quit() {
#     echo "$red"
#     echo "Do you want to quit ? (y/n)"
#     read ctrlc
#     if [ "$ctrlc" = 'y' ]; then
#         exit
#     fi
#     echo $reset
# }

# trap quit SIGINT
# trap quit SIGTERM

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 3`
reset=`tput sgr0`

# Base path
BASE_PATH=$(dirname "$0")            # relative
BASE_PATH=$(cd "$BASE_PATH" && pwd)    # absolutized and normalized
if [[ -z "$BASE_PATH" ]] ; then
	# error; for some reason, the path is not accessible
	# to the script (e.g. permissions re-evaled after suid)
	exit 1  # fail
fi

startSection() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo "${red}====>${blue} $1 ${reset}"
}

endSection() {
    echo "${red}====>${green} $1 ${reset}"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

# Updating the mirrors
startSection "َUpdating mirrors"
./install.d/updateMirrors.sh
startSection "َUpdated mirrors"

# Install all packages in pkglist.txt
startSection "Installing pacman packages"
./install.d/pacman.sh
endSection "Installed pacman packages successfully"

# Install all packages in aurlist.txt
startSection "Installing aur packages"
./install.d/yay.sh
endSection "Installed aur packages successfully"

# Append the alirOS script to the end of ~/.profile and ~/.zshrc file
./install.d/append-init-scripts.sh

# Install Node and enable corepack (yarn and stuff)
startSection "Installing Nodejs lts"
./install.d/node.sh
endSection "Installed Nodejs lts"

# Login to github-cli
startSection "Logging to Github"
./install.d/github.sh
endSection "Successfully logged in to Github"

# Start Nitrogen with one random picture
# from our wallpaper folder
#nitrogen --random --save ~/alirOS/wallpapers

# Apply chezmoi dotfiles from my own repository
startSection "Applying chezmoi dotfiles"
./install.d/chezmoi.sh
endSection "Successfully applyed chezmoi dotfiles"

# Enable services
./install.d/enable-services.sh

# Creating restic repo and making our first backup
startSection "Creating restic repo and making a backup"
./install.d/restic
endSection "Created restic repo and made a backup"

