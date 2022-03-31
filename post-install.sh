# This file is meant to run after install.sh has been 
# executed successfully

# Append the alirOS script to the end of ~/.zshrc file
echo "" # empty line
echo "# alirOS source script" >> ~/.zshrc
echo 'source ~/alirOS/init.sh' >> ~/.zshrc

# Set global git credentials
git config --global user.email "ali.rostmi@live.com"
git config --global user.name "Ali Rostami"

# Login to github-cli
gh auth login

# Apply chezmoi dotfiles from my own repository
chezmoi init --apply https://github.com/AliRostami1/dotfiles.git
