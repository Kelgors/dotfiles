alias ls="eza"
alias ll="eza -l"
alias lla="eza -la"
alias htop="htop -u $USER"
alias fcd="source $HOME/.config/zsh/scripts/fcd.sh"
if command -v batcat 2>&1 >/dev/null; then
  alias bat="batcat"
fi
