stow zsh

touch "$XDG_CONFIG_HOME/zsh/user.zsh"

# syntax-highlighting
clone_or_update_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "0.8.0" "$XDG_DATA_HOME/zsh/syntax-highlighting"

# autosuggestions
clone_or_update_repo "https://github.com/zsh-users/zsh-autosuggestions.git" "v0.7.0" "$XDG_DATA_HOME/zsh/autosuggestions"


# catppuccin/zsh-syntax-highlighting
theme_repo="https://github.com/catppuccin/zsh-syntax-highlighting.git"
theme_location="$XDG_DATA_HOME/zsh/catppuccin/zsh-syntax-highlighting"
if [ ! -d "$theme_location/.git" ]; then
	git clone "$theme_repo" "$theme_location"
fi
clone_or_update_repo "$theme_repo" "7926c3d3e17d26b3779851a2255b95ee650bd928" "$theme_location"
