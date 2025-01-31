#!/bin/zsh

# Clone neovim, build and install it at ~/.local/

# Check if neovim directory exists, if not clone the repo
if [ ! -d "neovim" ]; then
    git clone --depth 1 https://github.com/neovim/neovim
else
    git pull
    echo "neovim directory exists, pulling latest changes"
fi

cd neovim

make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/" CMAKE_BUILD_TYPE=Release
make install
