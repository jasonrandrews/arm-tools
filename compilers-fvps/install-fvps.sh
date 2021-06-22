#!/bin/bash

# first argument is username
if [ -z "$1" ]; then
    echo "pass a username"
    exit 
fi

pushd /home/$1/tmp/
./FVP_ARM_Std_Library.sh --i-agree-to-the-contained-eula -d /home/$1/FVP_ARM_Std_Library
popd
