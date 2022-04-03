#! /bin/zsh

# This file is meant to run first

# Make it so the script will exit on 
# command failure
set -e

quit() {
    echo "$red"
    echo "Do you want to quit ? (y/n)"
    read ctrlc
    if [ "$ctrlc" = 'y' ]; then
        exit
    fi
    echo $reset
}

trap quit SIGINT
trap quit SIGTERM

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

# Make tmp and var directory if not already
if [ ! -d "$BASE_PATH/var" ]; then
    mkdir $BASE_PATH/var
fi
if [ ! -d "$BASE_PATH/var" ]; then
    mkdir $BASE_PATH/tmp
fi


# Updating the mirrors
startSection "َUpdating mirrors"
until sudo pacman -Syy; do echo "Trying again"; done
startSection "َUpdated mirrors"

# Install all packages in pkglist.txt
startSection "Installing pacman packages"
until sudo pacman --needed -S - < pkglist.txt; do echo "Trying again"; done
endSection "Installed pacman packages successfully"

# Install all packages in aurlist.txt
startSection "Installing aur packages"
until yay --needed -S - < aurlist.txt; do echo "${blue}Trying again${reset}"; done
endSection "Installed aur packages successfully"

# Append the alirOS script to the end of ~/.profile and ~/.zshrc file
#startSection "Appending alirOS init script to .profile and .zshrc"
echo "" >> ~/.profile # empty line
echo "# alirOS source script" >> ~/.profile
echo 'source ~/alirOS/dotprofile-init.sh' >> ~/.profile

echo "" >> ~/.zshrc # empty line
echo "# alirOS source script" >> ~/.zshrc
echo 'source ~/alirOS/dotshell-init.sh' >> ~/.zshrc

source ~/.zshrc
#endSection "Successfully appended alirOS init script to .profile and .zshrc"

# Set global git credentials
git config --global user.email "ali.rostmi@live.com"
git config --global user.name "Ali Rostami"
# Set main as default branch name in git init
git config --global init.defaultBranch main

# Install Node and enable corepack (yarn and stuff)
startSection "Installing Nodejs lts"
until nvm install --lts; do echo "Trying again"; done
corepack enable 
endSection "Installed Nodejs lts"

# Login to github-cli
startSection "Logging to Github"
gh auth login
endSection "Successfully logged in to Github"

# Start Nitrogen with one random picture
# from our wallpaper folder
#nitrogen --random --save ~/alirOS/wallpapers

# Apply chezmoi dotfiles from my own repository
startSection "Applying chezmoi dotfiles"
until chezmoi init --apply https://github.com/AliRostami1/dotfiles.git; do echo "Trying again"; done
endSection "Successfully applyed chezmoi dotfiles"

# Enable services
sudo systemctl enable --now docker

# Creating restic repo and making our first backup
startSection "Creating restic repo and making a backup"
echo "${green}Where to create restic repo?"
while true; do
    read resticPath 
    if [ -d "$resticPath" ]; then
        # Take action if $DIR exists. #
        restic init --repo $resticPath
        echo $resticPath > $BASE_PATH/var/restic-repo
        restic -r $resticPath backup $HOME
        break
    else
        echo "${red}ERROR: $resticPath doesn't exist${reset}"
        echo "${green}Where to create restic repo?${reset}"
    fi
done
endSection "Created restic repo and made a backup"

