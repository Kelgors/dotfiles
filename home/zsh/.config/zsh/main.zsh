export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"
export MANPATH="$XDG_DATA_HOME/man:$MANPATH"

autoload=(
  bindings
  bin
  rc
  aliases
  user
)

for filename in "${autoload[@]}"; do
  if [ -f "$ZSH_CONFIG_PATH/$filename.zsh" ]; then
    source "$ZSH_CONFIG_PATH/$filename.zsh"
  else
    echo "Unable to load $ZSH_CONFIG_PATH/$filename.zsh !"
  fi
done

