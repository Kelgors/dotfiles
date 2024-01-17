selected=$(find . -maxdepth 1 -type d -print | fzf)
if [ ! -z "$selected" ]; then
  path="$(realpath $selected)"
  if [ -d "$path" ]; then
    cd $path
  fi
fi
