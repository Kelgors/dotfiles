#!/usr/bin/bash -e

function install_lsp_lua {
  sudo apt install build-essential ninja-build rsync -y
  local pkgname="lua-language-server"
  cd /tmp
  git clone https://github.com/LuaLS/$pkgname
  cd "$pkgname"
  git checkout 3.7.2
  ./make.sh

  echo '#!/bin/bash' > wrapper
  echo 'exec "/usr/local/bin/lua-language-server" "$@"' >> wrapper
  chmod +x wrapper

  sudo install -D wrapper /usr/local/bin/$pkgname
  sudo install -Dt /usr/lib/$pkgname/bin bin/$pkgname
  sudo install -m644 -t /usr/lib/$pkgname/bin bin/main.lua
  sudo install -m644 -t /usr/lib/$pkgname {debugger,main}.lua
  sudo rsync -r --exclude=.git locale meta script /usr/lib/$pkgname
  sudo install -Dm644 -t /usr/share/licenses/$pkgname LICENSE

}

if [ -f /usr/bin/pamac ]; then
  pamac install pyright lua-language-server rust-analyzer terraform-ls-bin
elif [ -f /usr/bin/pacman ]; then
  pacman -S pyright lua-language-server rust-analyzer terraform-ls-bin
elif [ -f /usr/bin/apt ]; then
  # Telescope
  sudo apt install fzf fd-find exa bat ripgrep
  # LSPs
  build_lsp_lua
else
  echo "Unable to find any supported package manager"
fi

yarn global add \
  @ansible/ansible-language-server \
  bash-language-server \
  dockerfile-language-server-nodejs @microsoft/compose-language-service \
  graphql-language-service-cli \
  @prisma/language-server \
  sql-language-server \
  typescript typescript-language-server \
  vscode-langservers-extracted \
  yaml-language-server

echo "Don't forget to add in your shell rc file:"
echo "export PATH=\"\$PATH:\$HOME/.yarn/bin\""
