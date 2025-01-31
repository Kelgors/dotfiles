stow starship
stow atuin

# bat => cat
# eza => ls
# skim => fzf
# fd-find => find
# ripgrep => grep
# bottom => top
# tealdeer => tldr
# delta => diff
# du-dust => du
# sd => sed
# starship (shell prompt)
# atuin (history in db)
# tokei (stats about filetypes)
# bandwhich (top for network)
# grex (create regex from examples)

packages=(
  bat
  eza
  skim
  fd-find
  ripgrep
  bottom
  starship
  atuin
  tokei
  tealdeer
)
for package in "${packages[@]}"; do
  echo "Installing $package..."
  cargo install "$package" --locked
done

tldr --update
