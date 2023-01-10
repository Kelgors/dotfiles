function install_deps {
    aurpkgmgr="yay"
    [[ -f $(command -v paru) ]] && aurpkgmgr="paru"

    sudo pacman -Syu git curl wget htop tar bat exa\
        fd ripgrep fzf the_silver_searcher rust vim\
        zsh zsh-syntax-highlighting zsh-history-substring-search zsh-theme-powerlevel10k

    $aurpkgmgr -Syua --noconfirm nvm nerd-fonts-complete cava termusic
}

function build_apps {
    mkdir -p $HOME/Builds
    build_gnome_connector
    build_zsh_theme
}

function build_gnome_connector {
    # gnome-browser-connector for 
    # - https://extensions.gnome.org/extension/615/appindicator-support/
    # - https://extensions.gnome.org/extension/4812/wallpaper-switcher/
    echo "Build gnome-browser-connector"
    cd $HOME/Builds
    if [[ -f $HOME/Builds/gnome-browser-connector ]];
    then 
        git clone https://aur.archlinux.org/gnome-browser-connector.git
        cd gnome-browser-connector
    else
        cd gnome-browser-connector
        git pull
    fi
    makepkg -si
    echo "[WARNING] Don't forget to install the browser extension."
}

function build_zsh_theme {
    echo "Build zsh config"
    cd $HOME/Builds
    if [[ -f $HOME/Builds/manjaro-zsh-config ]];
    then 
        git clone https://github.com/Chrysostomus/manjaro-zsh-config.git
        cd manjaro-zsh-config
    else
        cd manjaro-zsh-config
        git pull
    fi
    zshdir="/usr/share/zsh"
    # copy files
    sudo /usr/bin/cp manjaro-zsh-config $zshdir/
    sudo /usr/bin/cp manjaro-zsh-prompt $zshdir/
    # remove powerline10k config
    sudo sed -i 's/source \/usr\/share\/zsh\/p10k/# source \/usr\/share\/zsh\/p10k/' $zshdir/manjaro-zsh-prompt
}