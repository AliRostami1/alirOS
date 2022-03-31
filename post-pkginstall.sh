# add nvm source script to the end of ~/.zshrc file
echo "# nvm source script" >> ~/.zshrc
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc

# add git credentials
git config --global user.email "ali.rostmi@live.com"
git config --global user.name "Ali Rostami"
