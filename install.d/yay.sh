#! /bin/sh

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

# Install all packages in aurlist.txt
until yay --needed -S - < aurlist.txt; do echo "${blue}Trying again${reset}"; done
