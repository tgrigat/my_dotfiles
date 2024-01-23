
# cd and ls
c() { builtin cd "$@" && ls; }


refresh-build() {
  if [ "$(basename "$(pwd)")" != "build" ]; then
    echo "Warning: this alias should run at the build directory"
    echo "abort, please cd to build directory"
    return
  fi

  cd ..
  rm -rf build
  mkdir build
  cd build
}

# for opening zathura faster
# alias za="zathura"
za() {
  zathura $@ &
}
# for sioyek
# alias si="sioyek"
si() {
  sioyek $@ &
}

alias xo="xdg-open"

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

alias lg="lazygit"
alias ldocker="lazydocker"

alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'

alias vifm='vifm .'
alias ra='ranger . '
alias T='tmux new-session -A -s remote' 
alias tmux='tmux -u'
alias sudo="sudo "

alias pgrep="pdfgrep -r -n -i"

# kde xorg systemsettings
alias xcb-system="QT_QPA_PLATFORM=xcb systemsettings"

alias kssh="kitty +kitten ssh"

if (which dolphin > /dev/null); then
  alias d="dolphin . 2>/dev/null &" 
fi

alias xmind="xmind --no-sandbox"
# for fuzzy pdfgrep
alias pf="fuzzy-pdf -m 0"
# for the zoxide
alias z="zoxide "
# for fast go to downloads dir
alias down="cd ~/Downloads && vf "
# for the proxy
alias pxy="export http_proxy=http://127.0.0.1:1089;export https_proxy=http://127.0.0.1:1089;export ALL_PROXY=socks5://127.0.0.1:1089"
# for unproxy
alias unpxy='unset all_proxy; unset http_proxy; unset https_proxy'


alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'

alias vf="vfcd . " 

# alias ls="exa "
alias ls="ls --color --hyperlink=auto "
alias ll="ls -la "

alias zshconf="vim ~/.zshrc"
alias conf="cd ~/.config && vim"
alias dot="cd ~/dotfiles && vim"
# for now I'm learning cpp. I want to fast cd to the directory
alias cppcourse="cd /home/yang/Desktop/CPP && vf "
# for helping zotero get rid of enforced dark theme 
alias zotero="GTK_THEME=Default zotero "

if [[ -d ~/obsidian ]]; then
  alias note='cd ~/obsidian && vim '
fi

# where I put my note at mac
if [[ -d ~/Documents/obsidian ]]; then
  alias note='cd ~/Documents/obsidian && vim '
fi

if [[ "${SHELL##*/}" = "zsh" ]]; then
  alias refresh-fzf="rm ~/.local/bin/fzf && exec zsh"
fi

if (which vdirsyncer > /dev/null); then
  alias vsync="vdirsyncer sync"
fi

if (which zellij > /dev/null); then
  alias zj="zellij"
  function zjc() {
    local hostname=$(hostname)
    zellij options --simplified-ui true --pane-frames false --session-name $hostname "$@"
  }
fi

if (which yazi > /dev/null); then
  alias yz="yazi"
fi

# if (which lvim > /dev/null); then
#   alias vim="lvim "
# fi

if (which distrobox > /dev/null); then
  alias dsb="distrobox "
fi

if command -v pacman &> /dev/null; then
  alias S='sudo pacman -S'
  alias Sa='paru -Sa'
  alias Syu='sudo pacman -Syu'
  alias R='sudo pacman -R'
  alias Rns='sudo pacman -Rns'
  alias Fy='sudo pacman -Fy'
  alias syu='paru -Syu'
  alias Ss='pacman -Ss'
  alias Si='pacman -Si'
  alias Ssa='paru -Ssa'
  alias Qs='pacman -Qs'
  alias Qi='pacman -Qi'
  alias Ql='pacman -Ql'
  alias Qo='pacman -Qo'
  alias Qe='pacman -Qe'
  alias Qdt='pacman -Qdt'
  alias Qdtq='pacman -Qdtq'
  alias Qql='pacman -Qql'
  alias Fl='pacman -Fl'
  alias Fx='pacman -Fx'
  alias G='paru -G'
fi

function sudo() {
    case $1 in 
        vi|vim|nvim|lvim) command sudo -E "$@";;
        *) command sudo "$@";;
    esac
}

function man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

function ln-ccjson() {
  # Get the current directory
  local current_dir=$(pwd)

  # Get the base name of the current directory
  local base_name=$(basename $current_dir)

  # Check if the base name is 'build'
  if [[ $base_name == 'build' ]]; then
    # Get the project root path
    local project_root=$(dirname $current_dir)

    # Check if compile_commands.json exists in the current directory
    if [[ -f "$current_dir/compile_commands.json" ]]; then
      # Create a soft link to the project root
      ln -s "$current_dir/compile_commands.json" "$project_root/compile_commands.json"
      echo "Soft link created successfully."
    else
      echo "Error: compile_commands.json does not exist in the current directory."
    fi
  else
    echo "Error: The base name of the current directory is not 'build'. You should use this alias in the build folder"
  fi
}
