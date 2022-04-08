#! /bin/sh

# Creating restic repo and making our first backup
while true; do
    read -e -p "${green}Where to create restic repo? ${reset} " resticPath
    if [ -d "$resticPath" ]; then
        # Take action if $DIR exists. #
        restic init --repo $resticPath
        echo $resticPath > $BASE_PATH/var/restic-repo
        restic -r $resticPath backup $HOME
        break
    else
        echo "${red}ERROR: $resticPath doesn't exist${reset}"
    fi
done