if ! command -v rustup 2>&1 >/dev/null; then
  echo "Installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  . "$HOME/.cargo/env"
fi

rustup override set stable
rustup update stable
rustup component add rls rust-analysis rust-src
