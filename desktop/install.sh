project_path=$(pwd)
if [[ -z $USER ]];
then
	echo "You should not execute this script as root..."
	echo "Ctrl-C to quit or wait 5 seconds"
	sleep 5
	USER=root
fi
# Install dependencies
source ./arch.sh 
install_deps
sleep 2

echo "Setup home config"
# Prepare local & .config directory
mkdir -p ~/.local/share
mkdir -p ~/.config/nvim

[[ ! -f ~/.config/nvim/init.lua ]] && curl --silent --output ~/.config/nvim/init.lua https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua && echo "- neovim"
[[ -z $(sudo crontab -u $USER -l) ]] && sudo crontab -u $USER "$project_path/config/crontab"

# Link config directory
confdirs="alacritty bottom cava handlr hypr mako powerlevel10k rofi tmux"
for confdir in $confdirs
do
	echo "- $confdir"
	[[ -d ~/.config/$confdir ]] && rm -r ~/.config/$confdir
	ln -sf $project_path/config/$confdir ~/.config/$confdir
done

# Specific links
# Link tmux config to .tmux.conf
ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
# Link powerlevel10k config to .p10k.zsh
ln -sf ~/.config/powerlevel10k/p10k.zsh ~/.p10k.zsh
[[ -z ~/.config/hypr/monitors.conf ]] && echo "monitor=,preferred,auto,auto" > ~/.config/hypr/custom.conf

# User profile variables
[[ -z ~/.$USER.profile ]] && cp $(dirname $project_path)/user.profile ~/.$USER.profile && echo "~/.$USER.profile"
[[ -z ~/.zshrc ]] && cp $project_path/config/default.zshrc ~/.zshrc && echo "~/.zshrc"

build_apps
