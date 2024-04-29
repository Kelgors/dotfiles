#!/bin/bash -eu
DEPDIR="$HOME/.local/share"

# Ensure that .local/bin directory is not symlinked
mkdir -p "$HOME/.local/bin/"
touch "$HOME/.local/bin/.keep"

# stow -v nvim
stow -v zsh
stow -v htop
stow -v tmux

touch "$HOME/.config/zsh/user.zsh"

# zsh dependencies
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$DEPDIR/zsh/syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$DEPDIR/zsh/autosuggestions"
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git "$DEPDIR/catppuccin/zsh-syntax-highlighting"
curl -sS https://starship.rs/install.sh | BIN_DIR=~/.local/bin sh
# tmux deps
git clone https://github.com/tmux-plugins/tpm "$DEPDIR/tmux/tpm"

cat <<EOF
You need to install: zsh
Run: chsh -s \$(which zsh)
EOF
