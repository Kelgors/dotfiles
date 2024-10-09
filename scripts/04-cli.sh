stow starship
stow atuin

packages=(
  bat
  eza
  skim
  fd-find
  ripgrep
  bottom
  starship
  atuin
)
for package in "${packages[@]}"; do
  echo "Installing $package..."
  cargo install "$package" --locked
done
