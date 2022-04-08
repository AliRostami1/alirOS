#! /bin/sh

# Login to github-cli
until gh auth login; do echo "Trying again"; done
