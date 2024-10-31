#!/bin/zsh

# Clone neovim, build and install it at ~/.local/

# Check if neovim directory exists, if not clone the repo
if [ ! -d "neovim" ]; then
    git clone --depth 1 https://github.com/neovim/neovim
fi

cd neovim

make CMAKE_BUILD_TYPE=Release CMAKE_INSTLL_PREFIX=$HOME/.local
make install
