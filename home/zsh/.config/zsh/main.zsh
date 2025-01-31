export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"
export MANPATH="$XDG_DATA_HOME/man:$MANPATH"

autoload=(
  bindings.zsh
  bin.zsh
  rc.zsh
  aliases.zsh
  user.zsh
)

if [ -d "$ZSH_CONFIG_PATH/autoload" ]; then
  for filename in $ZSH_CONFIG_PATH/autoload/*; do
    autoload+=(${filename//$ZSH_CONFIG_PATH\//})
  done
fi

for filename in "${autoload[@]}"; do
  if [ -f "$ZSH_CONFIG_PATH/$filename" ]; then
    source "$ZSH_CONFIG_PATH/$filename"
  else
    echo "Unable to load $ZSH_CONFIG_PATH/$filename !"
  fi
done

