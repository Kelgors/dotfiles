path=$(pwd)
rcfile=".bashrc"
if [[ -f $HOME/.zshrc ]];
then
	rcfile=".zshrc"
fi

if [[ -z $USER ]];
then
	echo "You should not execute this script as root..."
	echo "Ctrl-C to quit or wait 5 seconds"
	sleep 5
	USER=root
fi


# Install deps, nvm, rust, vim
echo "  Installing dependencies..."
sudo apt install -y\
	build-essential git curl wget htop tar\
	bat exa fd-find ripgrep\
	fzf silversearcher-ag\
	vim tmux

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Link config directory
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config

# Link config directory
confdirs="nvim tmux"
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

$SHELL
