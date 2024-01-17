#!/usr/bin/zsh -eu
DEPDIR="$HOME/.local/share"

stow -v nvim
stow -v zsh
stow -v htop

# zsh dependencies
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$DEPDIR/zsh/syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$DEPDIR/zsh/autosuggestions"
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git "$DEPDIR/catppuccin/zsh-syntax-highlighting"
# tmux deps
git clone https://github.com/tmux-plugins/tpm "$DEPDIR/tmux/tpm"