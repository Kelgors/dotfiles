selected=$(find . -maxdepth 1 -type d -print | fzf)
if [ ! -z "$selected" ]; then
  fcd_path="$(realpath $selected)"
  if [ -d "$fcd_path" ]; then
    cd $fcd_path
  fi
fi
