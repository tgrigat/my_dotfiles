#!/bin/bash

# Update PATH
export PATH="~/.local/bin:${PATH}"

# get eget
curl -o eget.sh https://zyedidia.github.io/eget.sh
bash eget.sh
mv eget ~/.local/bin/

# eget
eget sharkdp/fd --asset ^musl --to ~/.local/bin
eget BurntSushi/ripgrep --to ~/.local/bin
eget jesseduffield/lazygit --to ~/.local/bin
eget zellij-org/zellij --to ~/.local/bin
