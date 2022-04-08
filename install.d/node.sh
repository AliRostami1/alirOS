#! /bin/sh

# nvm init script
source /usr/share/nvm/init-nvm.sh

# Install Node and enable corepack (yarn and stuff)
until nvm install --lts; do echo "Trying again"; done
corepack enable 