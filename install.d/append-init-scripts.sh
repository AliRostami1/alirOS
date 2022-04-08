#! /bin/sh

# Append the alirOS script to the end of ~/.profile and ~/.zshrc file
echo "" >> ~/.profile # empty line
echo "# alirOS source script" >> ~/.profile
echo 'source ~/alirOS/dotprofile-init.sh' >> ~/.profile

echo "" >> ~/.zshrc # empty line
echo "# alirOS source script" >> ~/.zshrc
echo 'source ~/alirOS/dotshell-init.sh' >> ~/.zshrc