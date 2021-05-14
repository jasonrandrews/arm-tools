#!/bin/bash

# first argument is username
if [ -z "$1" ]; then
    echo "pass a username"
    exit 
fi

pushd /home/$1/tmp/FastModels_11-14-021_Linux64
./setup.sh --i-accept-the-license-agreement --basepath /home/$1/FM
popd
