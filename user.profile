version=$(lsb_release -is)

export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export CODEEDITOR="/usr/bin/nvim"
[[ -f /usr/bin/firefox ]] && export BROWSER="/usr/bin/firefox"

alias ls="/usr/bin/exa"
alias ll="/usr/bin/exa -l"
alias lla="/usr/bin/exa -la"
if [[ -f $(command -v vim) ]];
then
    alias vim="/usr/bin/nvim"
fi

if [[ $version = "Debian" ]];
then
    alias bat="batcat"
    alias fd="fdfind"
fi
