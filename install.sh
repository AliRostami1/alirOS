#! /bin/sh

# This file is meant to run first

# Make it so the script will exit on 
# command failure
set -e

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 3`
reset=`tput sgr0`

startSection() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo "${red}====>${blue} $1 ${reset}"
}

endSection() {
    echo "${red}====>${green} $1 ${reset}"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

# Install all packages in pkglist.txt
startSection "Installing pacman packages"
sudo pacman -S - < pkglist.txt
endSection "Installed pacman packages successfully"


# Install all packages in aurlist.txt
startSection "Installing aur packages"
yay -S - < aurlist.txt
endSection "Installed aur packages successfully"


# Append the alirOS script to the end of ~/.profile and ~/.zshrc file
#startSection "Appending alirOS init script to .profile and .zshrc"
echo "" >> ~/.profile # empty line
echo "# alirOS source script" >> ~/.profile
echo 'source ~/alirOS/dotprofile-init.sh' >> ~/.profile

echo "" >> ~/.zshrc # empty line
echo "# alirOS source script" >> ~/.zshrc
echo 'source ~/alirOS/dotshell-init.sh' >> ~/.zshrc
#endSection "Successfully appended alirOS init script to .profile and .zshrc"

# Set global git credentials
#startSection "Setting git credentials"
git config --global user.email "ali.rostmi@live.com"
git config --global user.name "Ali Rostami"
#endSection "Successfully set git credentials"

# Login to github-cli
startSection "Logging to Github"
gh auth login
endSection "Successfully logged in to Github"

# Start Nitrogen with one random picture
# from our wallpaper folder
#nitrogen --random --save ~/alirOS/wallpapers

# Apply chezmoi dotfiles from my own repository
startSection "Applying chezmoi dotfiles"
chezmoi init --apply https://github.com/AliRostami1/dotfiles.git
endSection "Successfully applyed chezmoi dotfiles"

