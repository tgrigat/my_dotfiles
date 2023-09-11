#!/usr/bin/bash

function eget_install() {
  # get eget
  curl -o eget.sh https://zyedidia.github.io/eget.sh
  bash eget.sh
  mv eget ~/.local/bin/

  # eget
  eget sharkdp/fd --asset ^musl --to ~/.local/bin
  eget BurntSushi/ripgrep --to ~/.local/bin
  eget jesseduffield/lazygit --to ~/.local/bin
}

function nvm_install() {
  # nvm and then install node
  touch ~/.bashrc
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  source ~/.bashrc
  nvm install node
  npm install neovim tree-sitter-cli
}

# Update PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo "~/.local/bin is not in the PATH, Make sure to add it to your config:"
  echo "export PATH="~/.local/bin:$PATH""
  export PATH="~/.local/bin:${PATH}"
else
  echo "~/.local/bin is in the PATH"
fi

# Check for git, python, curl and pip3
for cmd in git python curl pip3
do
  if ! command -v $cmd &> /dev/null
  then
    echo "Error: $cmd is not installed."
    exit 1
  fi
done

# Check if '-a' flag is passed
if [[ "$1" == "-a" ]]; then
  eget_install
  nvm_install
fi

# get and install neovim
# export NEOVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
# export NVIM_ASSET=$(basename "$NEOVIM_URL")
# curl -OL $NEOVIM_URL
# tar xf $NVIM_ASSET --strip-components=1 -C ~/.local

bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install-neovim-from-release)

# Install lunarvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies
