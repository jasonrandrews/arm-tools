#!/bin/bash

docker run -it --rm --privileged --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY $*  armswdev/arm-tools:corstone-300-ml-eval-kit-gitpod
