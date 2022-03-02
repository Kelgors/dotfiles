#!/bin/bash

setxkbmap -model pc105 -layout fr -variant ,azerty
numlockx on

# setup screen disposition for work
if [[ $WORKPLACE = "WORK" ]];
then
  xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 1920x1080 --left-of eDP1
elif [[ $WORKPLACE = "HOME" ]];
then
  echo "TODO"
  # xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 1920x1080 --left-of eDP1
fi

if [[ -f $(which leftwm) ]];
then
  leftwm command SoftReload
fi
