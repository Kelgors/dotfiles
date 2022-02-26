#!/bin/bash

if [[ ! -f $(which feh) ]];
then
  echo "Installing dependencies"
  sudo apt install \
    libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
    libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev \
    libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
    libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev \
    uthash-dev libev-dev libx11-xcb-dev meson \
    i3lock \
    feh compton polybar xmobar lemonbar conky dmenu # leftwm deps
fi

echo "Building picom"
if [[ ! -d $HOME/Build/picom ]];
then
  cd $HOME/Build
  git clone https://github.com/yshui/picom && cd picom
else
  cd $HOME/Build/picom
  meson setup --wipe . build
  git pull
fi

git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

echo "Installing leftwm"
cargo install leftwm
if [[ ! -f /usr/share/xsessions/leftwm.desktop ]];
then
  sudo curl https://raw.githubusercontent.com/leftwm/leftwm/main/leftwm.desktop > /usr/share/xsessions/leftwm.desktop
fi

if [[ ! -d $HOME/Build/leftwm-theme ]];
then
  cd $HOME/Build
  git clone https://github.com/leftwm/leftwm-theme && cd leftwm-theme
else
  cd $HOME/Build/leftwm-theme
  git pull
fi
cargo build --release
strip -s target/release/leftwm-theme
sudo install -s -Dm755 target/release/leftwm-theme -t /usr/bin
cargo clean

if [[ ! -f $(which xwobf) ]];
then
  echo "Installing xwobf"
  sudo apt-get install libmagickwand-dev
  cd $HOME/Build
  git clone https://github.com/PhABC/xwobf && cd xwobf
  git switch libmagick6
  make
  sudo make install
fi


