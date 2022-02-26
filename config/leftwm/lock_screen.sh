#!/bin/bash
if [[ (-f $(which i3lock)) && (-f $(which i3lock)) ]];
then
  xwobf -s 7 /tmp/.i3lock.png
  i3lock -i /tmp/.i3lock.png
else
  slock
fi


