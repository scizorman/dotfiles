#!/usr/bin/env zsh
# PATH
typeset -gxU path PATH
path=( \
  $HOME/bin(N-/) \
  $HOME/.local/bin \
  /usr/local/bin \
  "$path[@]" \
)

# FPATH
# NOTE: Set fpath before compinit
typeset -gxU fpath FPATH
fpath=( \
  $HOME/.zsh/completions(N-/) \
  $HOME/.zsh/functions(N-/) \
  "$fpath[@]" \
)

# Initialize 'anyenv'
export ANYENV_ROOT="$HOME/.anyenv"
export ANYENV_DEFINITION_ROOT="$XDG_CONFIG_HOME/anyenv/anyenv-install"
export PATH="$HOME/.anyenv/bin:$PATH"

ANYENV_INIT_SOURCE="$ZDOTDIR/anyenv-init.zsh"
if [[ -e ${ANYENV_INIT_SOURCE} ]]; then
  # ret=$(diff ${ANYENV_INIT_SOURCE} <(anyenv init - --no-rehash))
  # [[ $ret != "" ]] && anyenv init - --no-rehash > ${ANYENV_INIT_SOURCE}
  ret=$(diff ${ANYENV_INIT_SOURCE} <(anyenv init -))
  [[ $ret != "" ]] && anyenv init - > ${ANYENV_INIT_SOURCE}
else
  # anyenv init - --no-rehash > ${ANYENV_INIT_SOURCE}
  anyenv init - > ${ANYENV_INIT_SOURCE}
fi
source ${ANYENV_INIT_SOURCE}

# Go
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$PATH"

# Python
# Pipenv
export PIPENV_VENV_IN_PROJECT=true


# Google-Cloud-SDK
source "$HOME/google-cloud-sdk/path.zsh.inc"
# source "$HOME/google-cloud-sdk/completion.zsh.inc"


# Utility functions
# Export 'PLATFORM' variable as you see fit
function detect_os() {
  case "${(L):-$(uname)}" in
    *'darwin'*)
      PLATFORM='osx'
      ;;
    *'linux'*)
      PLATFORM='linux'
      ;;
    *'bsd'*)
      PLATFORM='bsd'
      ;;
  esac
  export PLATFORM
}

# Return true if runnint OS is 'OSX'
function is_osx() {
  detect_os
  if [[ $PLATFORM == 'osx' ]]; then
    return 0
  else
    return 1
  fi
}

# Return true if runnint OS is 'Linux'
function is_linux() {
  detect_os
  if [[ $PLATFORM == 'linux' ]]; then
    return 0
  else
    return 1
  fi
}

# Return true if runnint OS is 'FreeBSD'
function is_bsd() {
  detect_os
  if [[ $PLATFORM == 'bsd' ]]; then
    return 0
  else
    return 1
  fi
}


# Aliases
# 'ls' color
if is_osx; then
  alias ls='ls -GF'
else
  alias ls='ls -F --color'
fi

# Common aliases
alias ll='ls -lF'
alias la='ls -AF'
alias lla='ls -lAF'
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv='mv -i'
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"
alias du='du -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if is_osx; then
  alias sudo="${ZSH_VERSION:+nocorrect} sudo"
fi

# Global aliases
alias -g G='| grep'
alias -g L='| less'
alias -g X='| xargs'
alias -g N='| >/dev/null 2>&1'
alias -g N1='| >/dev/null'
alias -g N2='| 2>/dev/null'

(( $+galiases[H] )) || alias -g H='| head'
(( $+galiases[T] )) || alias -g T='| tail'

if is_osx; then
  alias -g CP='| pbcopy'
  alias -g CC='tee /dev/tty | pbcopy'
fi


# Keybind
# Vim-like key bind as default
bindkey -v

# Add Emacs-like keybind
bindkey -M viins '^F' forward-char
bindkey -M viins '^B' backward-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^Y' yank
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^G' send-break
bindkey -M viins '^D' delete-char-or-list
bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^K' kill-line
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history
bindkey -M vicmd '^Y' yank
bindkey -M vicmd '^W' backward-kill-word
bindkey -M vicmd '^U' backward-kill-line

# Surround.vim
autoload -Uz is-at-least
if is-at-least 5.0.8; then
  autoload -Uz surround
  zle -N delete-surround surround
  zle -N change-surround surround
  zle -N add-surround surround
  bindkey -a cs change-surround
  bindkey -a ds delete-surround
  bindkey -a ys add-surround
  bindkey -M visual S add-surround
fi

# Insert a last word
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'

# select hisotries
autoload -Uz select-history
zle -N select-history
bindkey '^h' select-history


# Completions
# Styles
# Completing grouping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''

# Completing misc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignored-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
