#! /bin/sh

# Make tmp and var directory if not already
if [ ! -d "$BASE_PATH/var" ]; then
    mkdir $BASE_PATH/var
fi
if [ ! -d "$BASE_PATH/var" ]; then
    mkdir $BASE_PATH/tmp
fi
