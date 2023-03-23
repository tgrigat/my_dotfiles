# Notes: Modern unix tools.
# 1. dust - du
# 2. duf - df
# 3. procs - ps
# 4. bottom - top
# 5. exa - ls
# 6. zoxide - cd
# 7. ripgrep - grep
# 8. bat - cat
# 9. httpie - curl
# 10. hyperfine - time
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.


function gui() {
  if [[ $1 = "x" ]]; then
    # todo fix this
    export XDG_SESSION_TYPE=x11
    export XDG_SESSION_TYPE=xcb
    export DISPLAY=:1
    startplasma-x11
  else
    export XDG_SESSION_TYPE=wayland
    export QT_QPA_PLATFORM=wayland
    exec startplasma-wayland
  fi
}


function notify() {
  if [[ -z "$1" ]]; then
    echo "done" > ~/.notify
  else
    echo "$1" > ~/.notify
  fi
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
## alias for temporary usage

if [ $(hostname) = "node" ]; then
  export DET_MASTER=https://determined.corp.deepmirror.com:443 
  # alias ezpxy="export http_proxy=http://localhost:8888;export https_proxy=http://localhost:8888;export ALL_PROXY=socks5://localhost:1080"
  alias ezpxy="export http_proxy=http://localhost:8888;export https_proxy=http://localhost:8888"
  alias apdir="cd ~/Desktop/Advanced-programming/tutorials"
  export EDITOR=lvim
fi
alias wk="cd ~/Documents/git/autsys-projects-f4/"
alias wk2="cd ~/Documents/git/cliai/"
alias wk1="cd ~/Documents/git/DSOPP/"
# Set up the prompt
#----------------------------------------------------------------------------------------------------
# completion settings
#----------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit -d $ZCOMPDUMPFILE
setopt globdots

setopt complete_aliases
setopt auto_menu 
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ''
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# cd options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt interactive_comments
setopt auto_continue
# setopt extended_glob
setopt listpacked
setopt magic_equal_subst

# rm option
setopt rm_star_silent

# setup cache directory if not exist
[[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh;

#----------------------------------------------------------------------------------------------------
# history settings
#----------------------------------------------------------------------------------------------------
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history


#######################
# Here are environment variables
#
# export QT_QPA_PLATFORM="wayland;xcb"
#######################

alias chat="cliai chat"

alias pls="please "
alias kssh="kitty +kitten ssh"
alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'
alias xo="xdg-open"
alias lg="lazygit"
alias ldocker="lazydocker"
alias xcb-system="QT_QPA_PLATFORM=xcb systemsettings"
alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

if [[ "${SHELL##*/}" = "zsh" ]]; then
  alias refresh-fzf="rm ~/.local/bin/fzf && exec zsh"
fi

if (which distrobox > /dev/null); then
  alias dsb="distrobox "
fi

if [ -d "/etc/ros/noetic" ] && [ $SHELL = "/bin/zsh" ]; then
    source /etc/ros/noetic/setup.zsh
fi

alias clean-nvim="rm -rf ~/.local/share/nvim/site/pack/packer/start/"

if (which lvim > /dev/null); then
  alias vim="lvim "
fi
alias mvim="nvim "
alias note='cd ~/obsidian && vim '
alias vimrc='cd ~/.config/nvim'
alias desktop='cd ~/Desktop'
alias texd='cd ~/Desktop/Code/Latex'
alias lvimconf="cd ~/.local/share/lunarvim/lvim && vim"

# alias e='exit'
alias vifm='vifm .'
alias ra='ranger . '
alias gnome-cc='gnome-control-center'
alias T='tmux new-session -A -s remote' 
alias Tt='tmux new-session -A -s local'  
alias tk='task'
alias tm='timew'
alias tmux='tmux -u'
alias sudo="sudo "
# alias matlab="matlab -softwareopengl"
# for startup the script
alias letsgo="zsh /home/yang/startup.sh"
# for xmind to start properly
alias xmind="xmind --no-sandbox"
# for deactivating conda fast
alias conda-d="conda deactivate"
alias conda-a="conda activate"
# for fast SSH_CONNECTION
alias sshi="ssh iWorkstation"
# for ml3d conda
alias 3dml="conda activate 3dml"
# for ankis from terminal
alias ankis="ankisync && anki && ankisync"
# for fast cd to desktop
alias d="dolphin . 2>/dev/null &" 
# alias c="cd && ls "
# for pdfgrep
alias pgrep="pdfgrep -r -n -i"

ln-ccjson() {
ln -s build/compile_commands.json compile_commands.json
echo "Link performed, please ensure that you run this command at the project root"
}

refresh-build() {
  echo "Warning: this alias should run at build directory "
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

if command -v moar &> /dev/null; then
  export PAGER=moar
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

# cd and ls
c() { builtin cd "$@" && ls; }

function man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}



# press S to quit vifm and move to pwd
function vfcd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}

# press Q to quit ranger and move to pwd
function ranger() {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
    command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

function sudo() {
    case $1 in 
        vi|vim|nvim) command sudo -E "$@";;
        *) command sudo "$@";;
    esac
}

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

export PATH="${PATH}:/usr/local/cuda-11.5/bin"
export LD_LIBRARY="${LD_LIBRARY}:/usr/local/cuda-11.5/lib64"
export PATH=~/.local/bin:$PATH

# setting the ledger file to the obsidian 
export LEDGER_FILE=/home/yang/introspector/My\ Second\ Brain/transactions.ledger

export HISTFILE=~/.cache/zsh/zsh_history
export ZCOMPDUMPFILE=~/.cache/zsh/zcompdump


if (which fzf > /dev/null); then 
    if [[ -f /usr/bin/fzf ]]; then
        [[ $- == *i* ]] && source /usr/share/fzf/completion.zsh 2> /dev/null
        source /usr/share/fzf/key-bindings.zsh
    else
        [[ $- == *i* ]] && source ~/.local/share/fzf/shell/completion.zsh 2> /dev/null
        source ~/.local/share/fzf/shell/key-bindings.zsh
    fi
else
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.local/share/fzf
    ~/.local/share/fzf/install --no-bash --no-fish --no-key-bindings --no-completion --no-update-rc --bin
    ln -s ~/.local/share/fzf/bin/fzf ~/.local/bin/fzf
    echo "fzf will be available for next shell instance"
fi
eval bindkey '^R' fzf-history-widget


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yang/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yang/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yang/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yang/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda ...ENVS)

# prompt
if [[ $TTY =~ "/dev/tty" ]]; then
    autoload -Uz promptinit && promptinit
    prompt redhat
else
    if (which starship > /dev/null);then
        # use starship if avaliable
        eval "$(starship init zsh)"
    else
        #========================================
        # powerlevel10k configs
        #========================================
        # left prompts
        if [[ -z "$SSH_CONNECTION" ]]; then
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
            POWERLEVEL9K_USER_DEFAULT_BACKGROUND='232'
            POWERLEVEL9K_USER_DEFAULT_FOREGROUND='250'
            POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
            POWERLEVEL9K_USER_ROOT_FOREGROUND='232'
        else
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir vcs)
            POWERLEVEL9K_HOST_BACKGROUND='232'
            POWERLEVEL9K_HOST_FOREGROUND='250'
            POWERLEVEL9K_SSH_ICON="\uF489"
        fi
        # left colors
        # use some custom grey instead of black to avoid transparency
        POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='045'
        POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
        POWERLEVEL9K_DIR_ETC_BACKGROUND='045'
        POWERLEVEL9K_DIR_ETC_FOREGROUND='000'
        POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
        POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
        POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
        POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
        # right prompts
        POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status root_indicator dir_writable)
        # right colors
        POWERLEVEL9K_STATUS_OK_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='250'
        POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='250'
        # only show error status
        POWERLEVEL9K_STATUS_OK=false
        # Vim mode indecator
        POWERLEVEL9K_VI_INSERT_MODE_STRING=''
        POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'
        #POWERLEVEL9K_VI_VISUAL_MODE_STRING='V' #visual mode does not exist(?)
        # shorten the directory path TODO: fix this
        POWERLEVEL9K_SHORTEN_DIR_LENTH=1
        POWERLEVEL9K_SHORTEN_DELIMITER=""
        POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
        if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
            source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
        else
            if [[ ! -f ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]]; then
                [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/plugins/powerlevel10k
            fi
            source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
        fi
    fi

    #========================================
    # prompt extensions
    #========================================
    # sudo pacman -S zsh-completions zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    autoload autosuggest-accept
    zle -N autosuggest-accept

    function check_plugin() {
        if [[ -f /usr/share/zsh/plugins/"$1"/"$1".zsh ]]; then
            source /usr/share/zsh/plugins/"$1"/"$1".zsh
        else
            if [[ ! -f ~/.local/share/zsh/plugins/"$1"/"$1".zsh ]]; then
                [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/zsh-users/"$1".git ~/.local/share/zsh/plugins/"$1"
            fi
            source ~/.local/share/zsh/plugins/"$1"/"$1".zsh
        fi
    }

    check_plugin zsh-syntax-highlighting
    check_plugin zsh-autosuggestions
    check_plugin zsh-history-substring-search

    unset -f check_plugin
fi

#----------------------------------------------------------------------------------------------------
# keybinding settings
#----------------------------------------------------------------------------------------------------
bindkey -v
bindkey '^ ' autosuggest-accept
# Use vim keys for select when autocomplete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Use vim keys for history search
zle -N history-substring-search-up
zle -N history-substring-search-down
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

key[SEnter]=OM # manually setup since terminfo is not avaliable
[[ -n "${key[SEnter]}"   ]] && bindkey "${key[SEnter]}"          accept-and-hold
[[ -n "${key[SEnter]}"   ]] && bindkey -M vicmd "${key[SEnter]}" accept-and-hold

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v zoxide &> /dev/null; then
  #############################################
  # Zoxide configuration 
  #############################################


  # =============================================================================
  #
  # Utility functions for zoxide.
  #

  # pwd based on the value of _ZO_RESOLVE_SYMLINKS.
  function __zoxide_pwd() {
      \builtin pwd -L
  }

  # cd + custom logic based on the value of _ZO_ECHO.
  function __zoxide_cd() {
      # shellcheck disable=SC2164
      \builtin cd -- "$@" >/dev/null
  }

  # =============================================================================
  #
  # Hook configuration for zoxide.
  #

  # Hook to add new entries to the database.
  function __zoxide_hook() {
      # shellcheck disable=SC2312
      \command zoxide add -- "$(__zoxide_pwd)"
  }

  # Initialize hook.
  # shellcheck disable=SC2154
  if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
      chpwd_functions+=(__zoxide_hook)
  fi

  # =============================================================================
  #
  # When using zoxide with --no-cmd, alias these internal functions as desired.
  #

  __zoxide_z_prefix='z#'

  # Jump to a directory using only keywords.
  function __zoxide_z() {
      # shellcheck disable=SC2199
      if [[ "$#" -eq 0 ]]; then
          __zoxide_cd ~
      elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
          __zoxide_cd "$1"
      elif [[ "$@[-1]" == "${__zoxide_z_prefix}"* ]]; then
          # shellcheck disable=SC2124
          \builtin local result="${@[-1]}"
          __zoxide_cd "${result:${#__zoxide_z_prefix}}"
      else
          \builtin local result
          # shellcheck disable=SC2312
          result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
              __zoxide_cd "${result}"
      fi
  }

  # Jump to a directory using interactive search.
  function __zoxide_zi() {
      \builtin local result
      result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "${result}"
  }

  # =============================================================================
  #
  # Commands for zoxide. Disable these using --no-cmd.
  #

  \builtin unalias z &>/dev/null || \builtin true
  function z() {
      __zoxide_z "$@"
  }

  \builtin unalias zi &>/dev/null || \builtin true
  function zi() {
      __zoxide_zi "$@"
  }

  if [[ -o zle ]]; then
      function __zoxide_z_complete() {
          # Only show completions when the cursor is at the end of the line.
          # shellcheck disable=SC2154
          [[ "${#words[@]}" -eq "${CURRENT}" ]] || return

          if [[ "${#words[@]}" -eq 2 ]]; then
              _files -/
          elif [[ "${words[-1]}" == '' ]]; then
              \builtin local result
              # shellcheck disable=SC2086,SC2312
              if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -i -- ${words[2,-1]})"; then
                  __zoxide_result="${result}"
              else
                  __zoxide_result=''
              fi
              \builtin printf '\e[5n'
          fi
      }

      function __zoxide_z_complete_helper() {
          \builtin local result="${__zoxide_z_prefix}${__zoxide_result}"
          # shellcheck disable=SC2296
          [[ -n "${__zoxide_result}" ]] && LBUFFER="${LBUFFER}${(q-)result}"
          \builtin zle reset-prompt
      }

      \builtin zle -N __zoxide_z_complete_helper
      \builtin bindkey "\e[0n" __zoxide_z_complete_helper
      if [[ "${+functions[compdef]}" -ne 0 ]]; then
          \compdef -d z
          \compdef -d zi
          \compdef __zoxide_z_complete z
      fi
  fi

  # =============================================================================
  #
  # To initialize zoxide, add this to your configuration (usually ~/.zshrc):
  #
  # eval "$(zoxide init zsh)"


  ############################################
  # Zoxide end of configuration
  ############################################
fi
