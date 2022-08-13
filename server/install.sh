path=$(pwd)
rcfile=".bashrc"
if [[ -f $HOME/.zshrc ]];
then
    rcfile=".zshrc"
fi

# Install deps, nvm, rust, neovim
echo "  Installing dependencies..."
sudo apt install -y\
    build-essential git curl wget htop tar\
    bat exa fd-find ripgrep\
    fzf silversearcher-ag\
    neovim

sh -c "curl -sfLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# Link config directory
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config

# nvim config directory
echo "    Linking .config/nvim"
[[ -d $HOME/.config/nvim ]] && rm -r $HOME/.config/nvim
ln -sf $path/config/nvim $HOME/.config/nvim

# User profile variables
if [[ ! -f $HOME/.$USER.profile ]];
then
    echo "Creating symlink for .$USER.profile"
    ln -sf $path/../user.profile $HOME/.$USER.profile
    
    if [[ "$(cat $HOME/$rcfile | sed -n "/# source personal variables/p" | wc -l)" -eq "0" ]];
    then
        echo "# source personal variables" >> $HOME/$rcfile
        echo "source \$HOME/.$USER.profile" >> $HOME/$rcfile
    fi
fi