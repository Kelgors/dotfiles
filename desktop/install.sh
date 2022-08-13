path=$(pwd)
rcfile=".bashrc"
if [[ -f $HOME/.zshrc ]];
then
	rcfile=".zshrc"
fi
was_nvm_installed=$(command -v nvm)
if [[ -z $USER ]];
then
	echo "You should not execute this script as root..."
	echo "Ctrl-C to quit or wait 5 seconds"
	sleep 5
	USER=root
fi

# Install deps, nvm, rust, neovim
echo "  Installing dependencies..."
if [[ -f $(command -v pamac) ]]; 
then
	sudo pamac install git curl wget htop tar bat exa neovim\
		fd ripgrep fzf the_silver_searcher\
		rust nvm
elif [[ -f $(command -v apt) ]];
then
	sudo apt install -y\
		build-essential git curl wget htop tar\
		bat exa fd-find ripgrep\
		fzf silversearcher-ag\
		neovim
	# Install Rust
	if [[ ! -d $HOME/.rustup ]];
	then
		echo " Installing Rust"
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	else
		rustup update
	fi
	# update nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
	echo "ERROR: Missing compatible package manager (apt or pamac)."
	exit 1
fi

sleep 2
# Install Node
if [[ ! -f $(command -v node) ]];
then
	if [[ ! -f "$was_nvm_installed" ]];
	then
		if [[ -f /usr/share/nvm/init-nvm.sh ]];
		then
			echo 'source /usr/share/nvm/init-nvm.sh' >> $HOME/$rcfile
			source /usr/share/nvm/init-nvm.sh
		else
			echo "export NVM_DIR=\"\$HOME/.nvm\"" >> $rcfile
			echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && source \"\$NVM_DIR/nvm.sh\"  # This loads nvm" >> $rcfile
			echo "[ -s \"\$NVM_DIR/bash_completion\" ] && source \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" >> $rcfile
			export NVM_DIR="$HOME/.nvm"
			[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
			[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
		fi

	fi
	nvm install --lts
fi

echo "  Update plug.vim"
sh -c "curl -sfLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# Prepare local directory
[[ ! -d $HOME/.local ]] && mkdir -p $HOME/.local/share
[[ ! -d $HOME/.local/share ]] && mkdir $HOME/.local/share

# Install powerline fonts
echo "    Linking .local/share/fonts"
[[ -d $HOME/.local/share/fonts ]] && rm -r $HOME/.local/share/fonts
ln -sf $path/local/share/fonts $HOME/.local/share/fonts

# Link config directory
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config

# nvim directory
echo "    Linking .config/nvim"
[[ -d $HOME/.config/nvim ]] && rm -r $HOME/.config/nvim
ln -sf $path/config/nvim $HOME/.config/nvim

# User profile variables (with nothing else)
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
