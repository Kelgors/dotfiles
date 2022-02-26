#!/bin/bash
source kelgors.profile
path=$(pwd)
mkdir -p $HOME/Build/ && cd $HOME/Build/

echo "Welcome to you new environment"

if [[ ! -f $(which fzf) ]];
then
echo "  Installing dependencies"
sudo apt update -q
sudo apt upgrade -y

sudo apt install -y \
  build-essential git curl wget htop tar # standard deps \
  fzf bat silversearcher-ag ripgrep # install fzf-vim deps \
  fish
fi

if [[ ! -d $HOME/.rustup ]];
then
  echo "  Installing Rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "  Rust already installed"
fi

if [[ ! -d $HOME/Build/node-$NODE_VERSION ]];
then
  echo "  Installing Node $NODE_VERSION"
  wget https://nodejs.org/dist/$NODE_VERSION/node-$noe_version.tar.xz
  tar xf node-$NODE_VERSION.tar.xz
  rm node-$NODE_VERSION.tar.xz
  $HOME/Build/node-$NODE_VERSION/bin/corepack enable
  cd $HOME
else
  echo "  Node $NODE_VERSION already installed"
fi

if [[ ! -f $(which nvim) ]];
then
  echo "  Installing nvim"
  sudo apt install -y neovim
fi
# add vim-plug
sh -c "curl -sfLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# local directory
[[ ! -d $HOME/.local ]] && mkdir -p $HOME/.local/share
[[ ! -d $HOME/.local/share ]] && mkdir $HOME/.local/share
[[ -d $HOME/.local/share/fonts ]] && rm -r $HOME/.local/share/fonts
ln -sf $path/local/share/fonts $HOME/.local/share/fonts

echo "  Setting config up"
config_folders="alacritty nvim"

for config_folder in $config_folders
do
  if [[ -d $HOME/.config/$config_folder ]];
  then
    echo "    Remove .config/$config_folder directory"
    rm -rf $HOME/.config/$config_folder
  fi
  echo "    Creating symlink to .config/$config_folder"
  ln -sf $path/config/$config_folder $HOME/.config/$config_folder
done

if [[ ! -f $HOME/.kelgors.profile ]];
then
  echo "Creating symlink for .kelgors.profile"
  ln -sf $path/kelgors.profile $HOME/.kelgors.profile
  echo "# source personal variables" >> $HOME/.bashrc
  echo "source \$HOME/.kelgors.profile" >> $HOME/.bashrc
fi

