#!/usr/bin/env zsh
# PATH
typeset -gxU path PATH
path=( \
  $HOME/bin(N-/) \
  $HOME/.local/bin \
  /usr/local/bin \
  $path \
)
if [[ $(uname) == 'Darwin' ]]; then
  path=(/usr/local/opt/*/libexec/gnubin $path)
  manpath=(/usr/local/opt/*/libexec/gnuman $mantpath)
fi

# FPATH
# NOTE: Set fpath before compinit
typeset -gxU fpath FPATH
fpath=( \
  $HOME/.zsh/completions(N-/) \
  $HOME/.zsh/functions(N-/) \
  $fpath \
)

# Linux specifics
if [ $(uname) = 'Linux' ]; then
  # Homebrew
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  # Docker Compose
  export PATH=$HOME/.docker/cli-plugins:$PATH

  # PostgreSQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/mysql-client/bin:$PATH
else
  # PostgreSQL Client
  export PATH=/usr/local/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/usr/local/opt/mysql-client/bin:$PATH
fi

# WSL2 specifics
if [[ $(uname -r) =~ 'microsoft' ]]; then
  export GPG_TTY=$(tty)
fi

# Go
export PATH=$HOME/sdk/go1.20.5/bin:$PATH
export GOPATH=${GOPATH:-$HOME/go}
export PATH="$GOPATH/bin:$PATH"

# Node
# Volta
export VOLTA_HOME=$HOME/.volta
export PATH=$VOLTA_HOME/bin:$PATH

# Deno
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH

# Python
# pyenv
PYENV_ROOT=$HOME/.pyenv
eval "$(pyenv init --path)"

# Poetry
export PATH=$HOME/.poetry/bin:$PATH
export POETRY_VIRTUALENVS_IN_PROJECT=true

# rye
source $HOME/.rye/env

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# direnv
eval "$(direnv hook zsh)"

# ghq
export GHQ_ROOT=$HOME/ghq

function ghq-cd() {
  local repository=$(ghq list | fzf +m)
  [[ -n $repository ]] && cd $(ghq root)/$repository
}

# Aliases
# Neovim
alias vi='nvim'
alias vim='nvim'

# ls -> exa
alias ls='exa'
alias ll='exa -lF --git'
alias la='exa -aF'
alias lla='exa -alF --git'
alias tree='exa -T --git-ignore'

# cat -> bat
alias cat='bat --theme=Dracula'

# grep -> ripgrep
alias grep='rg --color=auto'

# du -> dust
alias du='dust'

alias mv='mv -i'
alias rm='rm -i'
alias du='du -h'
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"
alias sudo="${ZSH_VERSION:+nocorrect} sudo"

# Clipboard
# Linux
if [ $(uname) = 'Linux' ]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
fi
# WSL2
if [[ $(uname -r) == *microsoft* ]]; then
  alias pbcopy='clip.exe'
  alias pbpaste='powershell.exe -Command Get-Clipboard'
fi

# ghq
alias gl='ghq-cd'

# Global aliases
alias -g G='| rg'
alias -g L='| less'
alias -g X='| xargs'
alias -g N='| >/dev/null 2>&1'
alias -g N1='| >/dev/null'
alias -g N2='| 2>/dev/null'

(( $+galiases[H] )) || alias -g H='| head'
(( $+galiases[T] )) || alias -g T='| tail'

alias -g CP='| pbcopy'
alias -g CC='tee /dev/tty | pbcopy'


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
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
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
