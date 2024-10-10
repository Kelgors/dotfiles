set -euo pipefail

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export BIN_HOME="${BIN_HOME:-$HOME/.local/bin}"

_stow=$(command -v stow)
stow() {
  "$_stow" "--target=$HOME" "--dir=$PWD/home" -v "$@"
}

# Ensure that .local/bin directory is not symlinked
mkdir -p "$BIN_HOME"
touch "$BIN_HOME/.keep"

stow htop

ls scripts | while read -r file; do
  if [[ "$file" != *.sh ]]; then
    continue
  fi
  echo "$file"
  . ./scripts/$file
done

