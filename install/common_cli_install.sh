#!/usr/bin/bash
# get eget
curl -o eget.sh https://zyedidia.github.io/eget.sh
bash eget.sh
mv eget ~/.local/bin/

# eget
eget sharkdp/fd --asset ^musl --to ~/.local/bin
eget BurntSushi/ripgrep --to ~/.local/bin
eget jesseduffield/lazygit --to ~/.local/bin
eget zellij-org/zellij --to ~/.local/bin
eget jesvedberg/tpix --to ~/.local/bin
eget hackerb9/lsix --to ~/.local/bin
eget ajeetdsouza/zoxide --to ~/.local/bin
eget junegunn/fzf --to ~/.local/bin
eget casey/just --asset unknown-linux --to ~/.local/bin
eget eza-community/eza --asset tar --to ~/.local/bin
eget sxyazi/yazi --asset linux-musl --to ~/.local/bin --file ya --file yazi
eget sxyazi/yazi --asset linux-musl --to ~/.local/bin --file ya --file yazi
eget aristocratos/btop --to ~/.local/bin
