#!/bin/zsh

# Clone neovim, build and install it at ~/.local/

# Clone the neovim repo
git clone --depth 1 https://github.com/neovim/neovim

cd neovim

make CMAKE_BUILD_TYPE=Release
make CMAKE_INSTLL_PREFIX=$HOME/.local install
