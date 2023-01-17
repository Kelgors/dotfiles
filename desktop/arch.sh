builddir=/tmp/Builds
mkdir -p $builddir

function install_paru {
    echo "Installing paru"
    sudo pacman --needed -Sy --needed base-devel sudo vi
    
    echo "Editing sudoers via visudo. Please ensure informations are correct"
    su -c "cat /etc/sudoers > /etc/sudoers.tmp && echo \"%wheel ALL=(ALL:ALL) ALL\" >> /etc/sudoers.tmp && visudo -f /etc/sudoers.tmp"

    cd $builddir
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

function install_deps {
    [[ -z $(command -v paru) ]] && install_paru

    echo "Installing desktop packages"
    paru --needed -S dcron htop openssh\
        zsh zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search zsh-theme-powerlevel10k\
        hyprland rofi-lbonn-wayland-git greetd greetd-tuigreet swaylock-effects swayidle mako grimblast-git\
        swww networkmanager pavucontrol hyprpicker wl-clipboard pipewire pipewire-alsa pipewire-pulse pipewire-jack\
        dex xdg-user-dirs libnotify polkit polkit-gnome\
        thunar thunar-volman thunar-archive-plugin file-roller\
        wireplumber xdg-desktop-portal-hyprland-git qt5-wayland qt6-wayland flatpak\
        nerd-fonts-noto-sans-mono alacritty fbterm nvm wget exa fzf termusic vlc tty-clock-git firefox bottom\
        ripgrep lazygit gdu \
        virt-manager qemu-desktop dnsmasq iptables-nft
    
    xdg-user-dirs-update
    mkdir ~/Pictures/Screenshots
    # FIX missing rofi theme
    # FIX missing file selection

    echo "Add user to groups"
    sudo usermod -aG users,video,storage,optical,input,audio,wheel $USER
    [[ ! -f $(command -v node) ]] && nvm install --lts

    sudo systemctl enable dcron
    sudo systemctl enable greetd
}

function build_apps {
    echo "Building apps"
    mkdir -p $builddir
    build_zsh_theme
    install_flatpaks
}

function build_zsh_theme {
    echo "- Fetch zsh config"
    cd $builddir
    if [[ -f $builddir/manjaro-zsh-config ]];
    then 
        cd manjaro-zsh-config
        git pull
    else
        git clone https://github.com/Chrysostomus/manjaro-zsh-config.git
        cd manjaro-zsh-config
    fi
    zshdir="/usr/share/zsh"
    # copy files
    sudo cp manjaro-zsh-config $zshdir/manjaro-zsh-config
    sudo cp manjaro-zsh-prompt $zshdir/manjaro-zsh-prompt
    # remove powerline10k config
    sudo sed -i 's/source \/usr\/share\/zsh\/p10k/# source \/usr\/share\/zsh\/p10k/' $zshdir/manjaro-zsh-prompt
}

function install_flatpaks {
    echo "Install flatpak apps"
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install --or-update --noninteractive com.github.IsmaelMartinez.teams_for_linux
    sudo flatpak install --or-update --noninteractive com.visualstudio.code
    sudo flatpak install --or-update --noninteractive md.obsidian.Obsidian
    sudo flatpak install --or-update --noninteractive org.filezillaproject.Filezilla
    sudo flatpak install --or-update --noninteractive org.gnome.gThumb
    sudo flatpak install --or-update --noninteractive rest.insomnia.Insomnia
    sudo flatpak install --or-update --noninteractive net.lutris.Lutris
}
