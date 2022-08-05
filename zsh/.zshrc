# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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



# Use emacs keybindings even if our EDITOR is set to vi

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
#HISTSIZE=1000
#SAVEHIST=1000
#HISTFILE=~/.zsh_history

# Use modern completion system
#autoload -Uz compinit
#compinit
#
#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
#
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# easy copy configuration from .config to zsh and tmux
# alias cpconf="cp /home/yang/.config/zsh/.zshrc /home/yang && cp /home/yang/.config/tmux/.tmux.conf /home/yang"
# alias udconf="cp /home/yang/.zshrc  /home/yang/.config/zsh/ && cp /home/yang/.tmux.conf /home/yang/.config/tmux/"

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

alias vim="nvim"
alias note='cd ~/introspector/My\ Second\ Brain && vim'
alias vimrc='cd ~/.config/nvim'
alias desktop='cd ~/Desktop'
alias texd='cd ~/Desktop/Code/Latex'
alias e='exit'
alias vifm='vifm .'
alias S='sudo paru -S'
alias Ss='sudo paru -Ss'
alias Syu='sudo paru -Syu'
alias gnome-cc='gnome-control-center'
alias T='tmux new-session -A -s remote' 
alias Tt='tmux new-session -A -s local'  
alias tk='task'
alias tm='timew'
alias tmux='tmux -u'
# for nvim remote
alias sudo="sudo "
alias matlab="matlab -softwareopengl"
# for startup the script
alias letsgo="zsh /home/yang/startup.sh"
# for xmind to start properly
alias xmind="xmind --no-sandbox"
# for deactivating conda fast
alias condad="conda deactivate"
# for fast SSH_CONNECTION
alias sshi="ssh iWorkstation"
# for ml3d conda
alias 3dml="conda activate 3dml"
# for ankis from terminal
alias ankis="ankisync && anki && ankisync"
# for fast cd to desktop
alias d="cd ~/Desktop && vf " 

alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'

alias vf="vfcd . " 

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
alias Fl='pacman -Fl'
alias Fx='pacman -Fx'
alias G='paru -G'

alias S='sudo pacman -S'
alias Sa='paru -Sa'
alias Syu='sudo pacman -Syu'
alias R='sudo pacman -R'
alias Rns='sudo pacman -Rns'
alias Fy='sudo pacman -Fy'

alias syu='paru -Syu'

alias ls="exa"

function vfcd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}

function sudo() {
    case $1 in 
        vi|vim|nvim) command sudo -E "$@";;
        *) command sudo "$@";;
    esac
}

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH
export PATH="${PATH}:/usr/local/cuda-11.5/bin"
export LD_LIBRARY="${LD_LIBRARY}:/usr/local/cuda-11.5/lib64"
export PATH=~/.local/bin:$PATH
export EDITOR=nvim

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
