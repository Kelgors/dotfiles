#!/bin/bash

if [[ ! -f $(which feh) ]];
then
  echo "Installing dependencies"
  sudo apt install \
    x11-xserver-utils xorg lightdm \
    libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
    libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev \
    libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev \
    libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev \
    uthash-dev libev-dev libx11-xcb-dev meson \
    i3lock \
    libssl-dev \
    pavucontrol \
    rofi feh compton polybar xmobar lemonbar conky dmenu # leftwm deps
fi

echo "Building picom"
if [[ ! -d $HOME/Build/picom ]];
then
  cd $HOME/Build
  git clone https://github.com/yshui/picom && cd picom
  git submodule update --init --recursive
  meson --buildtype=release . build
  ninja -C build
  sudo ninja -C build install
fi

echo "Installing leftwm"
cargo install leftwm
# ad to main path
sudo mv $HOME/.cargo/bin/leftwm* /usr/local/bin/
if [[ ! -f /usr/share/xsessions/leftwm.desktop ]];
then
  # add desktop entry
  [[ ! -d /usr/share/xsessions ]] && sudo mkdir /usr/share/xsessions
  sudo curl -o /usr/share/xsessions/leftwm.desktop https://raw.githubusercontent.com/leftwm/leftwm/main/leftwm.desktop
fi

if [[ ! -f $(which xwobf) ]];
then
  echo "Installing xwobf"
  sudo apt install libmagickwand-dev
  cd $HOME/Build
  git clone https://github.com/PhABC/xwobf && cd xwobf
  git switch libmagick6
  make
  sudo make install
fi

