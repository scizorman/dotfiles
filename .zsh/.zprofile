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

# Go
export PATH=$HOME/sdk/go1.19/bin:$PATH
export GOPATH=${GOPATH:-$HOME/go}
export PATH="$GOPATH/bin:$PATH"

# Node
# NVM
export NVM_DIR=$HOME/.nvm
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

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

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# SDKMAN
source $HOME/.sdkman/bin/sdkman-init.sh

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

alias mv='mv -i'
alias rm='rm -i'
alias du='du -h'
alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mkdir="${ZSH_VERSION:+nocorrect} mkdir"
alias sudo="${ZSH_VERSION:+nocorrect} sudo"

# Clipboard
if [ $(uname) = 'Linux' ]; then
  alias pbcopy='xclip -selection c'
  alias pbpaste='xclip -selection c -o'
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

# Google Chrome CLI
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'


# Keybind
# Vim-like key bind as default
bindkey -v

# Escape insert mode 
bindkey -M viins 'jj' vi-cmd-mode

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
