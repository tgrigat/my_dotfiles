FROM archlinux:base-devel as lvim

WORKDIR /root

ENV PATH="/root/.local/bin:${PATH}"

RUN pacman-key --init && pacman -Syu --noconfirm git python curl

# get eget
RUN curl -o eget.sh https://zyedidia.github.io/eget.sh && \
	bash eget.sh && \
	mv eget /usr/bin/

# eget
RUN eget sharkdp/fd --asset ^musl --to ~/.local/bin && eget BurntSushi/ripgrep --to ~/.local/bin && eget jesseduffield/lazygit --to ~/.local/bin

# nvm and then install node
RUN touch ~/.bashrc && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && exec bash && bash nvm install node && bash npm install neovim tree-sitter-cli

RUN export NEOVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz" && \
	export NVIM_ASSET=$(basename "$NEOVIM_URL") && \
	curl -OL $NEOVIM_URL && \
	tar xf $NVIM_ASSET --strip-components=1 -C ~/.local

RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --no-install-dependencies


