export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export CODEEDITOR="/usr/bin/nvim"
[[ -f /usr/bin/firefox ]] && export BROWSER="/usr/bin/firefox"

alias ls="/usr/bin/exa"
alias ll="/usr/bin/exa -l"
alias lla="/usr/bin/exa -la"
[[ ! -f $(command -v vim) ]] && alias vim="/usr/bin/nvim"
[[ -f $(command -v batcat) ]] && [[ ! -f $(command -v bat) ]] && alias bat="/usr/bin/batcat"
[[ -f $(command -v fdfind) ]] && [[ ! -f $(command -v fd) ]] && alias fd="/usr/bin/fdfind"
