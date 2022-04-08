#! /bin/sh

# Updating the mirrors
until sudo pacman -Syy; do echo "Trying again"; done
