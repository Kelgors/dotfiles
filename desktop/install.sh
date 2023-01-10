path=$(pwd)
rcfile=".zshrc"
was_nvm_installed=$(command -v nvm)
if [[ -z $USER ]];
then
	echo "You should not execute this script as root..."
	echo "Ctrl-C to quit or wait 5 seconds"
	sleep 5
	USER=root
fi

[[ -f $(command -v pacman) ]] && source ./arch.sh
install_deps
sleep 2

# Install Node
if [[ ! -f $(command -v node) ]];
then
	if [[ ! -f "$was_nvm_installed" ]];
	then
		echo 'source /usr/share/nvm/init-nvm.sh' >> $HOME/$rcfile
		source /usr/share/nvm/init-nvm.sh
	fi
	nvm install --lts
fi

echo "Install plug.vim"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Prepare local & .config directory
[[ ! -d $HOME/.local ]] && mkdir -p $HOME/.local/share
[[ ! -d $HOME/.local/share ]] && mkdir $HOME/.local/share
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config

# Link config directory
confdirs="alacritty nvim tmux powerlevel10k"
for confdir in $confdirs
do
	echo "Link ~/.config/$confdir"
	[[ -d $HOME/.config/$confdir ]] && rm -r $HOME/.config/$confdir
	ln -sf $path/config/$confdir $HOME/.config/$confdir
done

# Specific links
# Link nvim init.vim as .vimrc 
ln -sf $HOME/.config/nvim/init.vim $HOME/.vimrc
# Link tmux config to .tmuxrc
ln -sf $HOME/.config/tmux/tmux.conf $HOME/.tmuxrc
# Link powerlevel10k config to .p10k.zsh
ln -sf $HOME/.config/powerlevel10k/p10k.zsh $HOME/.p10k.zsh
# User profile variables (with nothing else)
ln -sf $path/../user.profile $HOME/.$USER.profile

[[ -z $HOME/.zshrc ]] && cp $path/config/default.zshrc $HOME/.zshrc

build_apps
