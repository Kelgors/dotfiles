#!/bin/bash

echo "Installing Alacritty"
alacritty_path=$(which alacritty)

if [[ ! -f $alacritty_path ]];
then
  echo "Install dependencies"
  sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
  echo "Cloning repo"
  mkdir -p $HOME/Build/ && cd $HOME/Build/
  git clone https://github.com/alacritty/alacritty.git
  cd alacritty
else
  echo " Updating alacritty"
  cd $HOME/Build/alacritty
  git pull
fi

echo "Building Alacritty"
cargo build --release
strip -s target/release/alacritty

echo "Add Desktop Entry"
if [[ ! -f $alacritty_path ]];
then
  sudo cp target/release/alacritty /usr/local/bin
  sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
  sudo desktop-file-install extra/linux/Alacritty.desktop
  sudo update-desktop-database
  echo "Alacritty is now installed."
else
  sudo cp target/release/alacritty $alacritty_path || echo -e "You're using Alacritty right now. Run this command to update Alacritty from another terminal\n  sudo cp target/release/alacritty $alacritty_path"
  echo "Alacritty is now updated"
fi

cargo clean
