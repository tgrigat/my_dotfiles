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

##############################################################################
# Laptop configurations
##############################################################################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
#----------------------------------------------------------------------------------------------------
# completion settings
#----------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
setopt globdots

setopt correct
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
zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' accept-exact '*(N)'

# cd options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent

setopt interactive_comments
setopt auto_continue
# setopt extended_glob
# setopt no_bare_glob_qual
setopt listpacked
setopt magic_equal_subst

# rm option
setopt rm_star_silent

setopt numeric_glob_sort

#----------------------------------------------------------------------------------------------------
# history settings
#----------------------------------------------------------------------------------------------------
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/zsh_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt share_history
setopt append_history

#----------------------------------------------------------------------------------------------------
# prompt settings
#----------------------------------------------------------------------------------------------------
# autoload -Uz promptinit && promptinit
# prompt redhat
autoload -U colors && colors
setopt prompt_subst

#----------------------------------------------------------------------------------------------------
# misc settings
#----------------------------------------------------------------------------------------------------

if command -v moar &> /dev/null; then
  export PAGER=moar
fi

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ $(uname) == "Darwin" ]]; then
  source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
  unalias ls
fi

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

function auto_compile() {
    if [[ $1 -nt $1.zwc ]] || [[ ! -e $1.zwc ]]; then
        zcompile -R $1
    fi
}

function auto_source() {
    auto_compile $1
    . $1
}

auto_source $ZDOTDIR/plugins.zsh
auto_source $ZDOTDIR/keys.zsh
auto_source $ZDOTDIR/alias.zsh
auto_source $ZDOTDIR/functions.zsh
auto_source $ZDOTDIR/device.zsh

unset -f auto_source

#----------------------------------------------------------------------------------------------------
# auto compile zshrc
auto_compile $ZDOTDIR/.zshrc
unset -f auto_compile

alias mba="micromamba"
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/yang/.mamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/yang/.mamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/yang/.mamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/yang/.mamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

