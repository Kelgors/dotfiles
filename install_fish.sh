#!/bin/bash
fish_version="3.3.1-1_amd64"

if [ -z $HOME/Build/fish/fish_$fish_version.deb ];
then
  echo "Installing Fish"
  mkdir -p $HOME/Build/fish && cd $HOME/Build/fish
  wget https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/amd64/fish_$fish_version.deb
  sudo apt -f install ./fish_$fish_version.deb
else
  echo "Fish $fish_version already installed"
fi

