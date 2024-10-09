stow tmux

# tpm
clone_or_update_repo "https://github.com/tmux-plugins/tpm" "v3.1.0" "$XDG_DATA_HOME/tmux/tpm"

## catppuccin/tmux
theme_repo="https://github.com/catppuccin/tmux.git"
theme_location="$XDG_CONFIG_HOME/tmux/plugins/catppuccin/tmux"
if [ ! -d "$theme_location/.git" ]; then
	git clone "$theme_repo" "$theme_location"
fi
clone_or_update_repo "$theme_repo" "4ca26b774bc2e945fce4ccb909245dffeea7a9bf" "$theme_location"
