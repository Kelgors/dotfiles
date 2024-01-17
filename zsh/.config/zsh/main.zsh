export ZSH_CONFIG_PATH="$HOME/.config/zsh"

autoload=(
  rc
  bin
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

