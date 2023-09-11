## My dot files

This is a repo that stores all important config file mappings in `destination.yaml` on all of my computers

## how to use confsync

In the repo:

```
python3 propogate_dotfiles.py
```

## Quick setup (for the editor)

Best to run it on home directory:

```
git clone https://github.com/LumenYoung/dotfiles
cd dotfiles
ln -s "$(pwd)/lvim" ~/.config/lvim
cd ..
bash $(curl -s https://raw.githubusercontent.com/LumenYoung/dotfiles/master/install/lvim_install.sh) # use -a to install all dependencies
```

## Quick setup (for all)

```
git clone https://github.com/LumenYoung/dotfiles
cd dotfiles
python3 propogate_dotfiles.py
cd ..
bash <(curl -s https://raw.githubusercontent.com/LumenYoung/dotfiles/master/install/lvim_install.sh) -a
```

## ZSH

Use a `~/.local.zsh` file to store zsh commands that will not be synced.
