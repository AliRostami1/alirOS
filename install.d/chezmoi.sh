#! /bin/sh

# Apply chezmoi dotfiles from my own repository
until chezmoi init --apply https://github.com/AliRostami1/dotfiles.git; do echo "Trying again"; done