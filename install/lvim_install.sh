#!/bin/bash

# Update PATH
export PATH="~/.local/bin:${PATH}"

# Check for git, python, curl and pip3
for cmd in git python curl pip3
do
  if ! command -v $cmd &> /dev/null
  then
    echo "Error: $cmd is not installed."
    exit 1
  fi
done

# get eget
curl -o eget.sh https://zyedidia.github.io/eget.sh
bash eget.sh
sudo mv eget ~/.local/bin/

# eget
eget sharkdp/fd --asset ^musl --to ~/.local/bin
eget BurntSushi/ripgrep --to ~/.local/bin
eget jesseduffield/lazygit --to ~/.local/bin

# nvm and then install node
touch ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm install node
npm install neovim tree-sitter-cli

# get and install neovim
export NEOVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
export NVIM_ASSET=$(basename "$NEOVIM_URL")
curl -OL $NEOVIM_URL
tar xf $NVIM_ASSET --strip-components=1 -C ~/.local

# Install lunarvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies

