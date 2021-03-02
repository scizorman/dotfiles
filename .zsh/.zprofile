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

if [ $(uname) = 'Linux' ]; then
  # Homebrew
  export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
  export MANPATH=/home/linuxbrew/.linuxbrew/share/man:$MANPATH
  export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:$INFOPATH
  export LD_LIBRARY_PATH=/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH

  # PostgreSQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/home/linuxbrew/.linuxbrew/opt/mysql-client/bin:$PATH

  # CUDA
  export PATH=/usr/local/cuda/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
else
  # PostgreSQL Client
  export PATH=/usr/local/opt/libpq/bin:$PATH

  # MySQL Client
  export PATH=/usr/local/opt/mysql-client/bin:$PATH
fi

# ghq
export GHQ_ROOT=$HOME/ghq

function ghq-cd() {
  local repository=$(ghq list | fzf +m)
  [[ -n $repository ]] && cd $(ghq root)/$repository
}

# Initialize 'anyenv'
export ANYENV_ROOT=$HOME/.anyenv
export ANYENV_DEFINITION_ROOT=$XDG_CONFIG_HOME/anyenv/anyenv-install
export PATH=$HOME/.anyenv/bin:$PATH
eval "$(anyenv init - --no-rehash)"

# SDKMAN
[[ -s $HOME/.sdkman/bin/sdkman-init.sh ]] && source $HOME/.sdkman/bin/sdkman-init.sh

# Go
export GOPATH=${GOPATH:-$HOME/go}
export PATH="$GOPATH/bin:$PATH"

# Python
# Pipenv
export PIPENV_VENV_IN_PROJECT=true

# Poetry
export PATH=$HOME/.poetry/bin:$PATH
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Rust
export PATH=$HOME/.cargo/bin:$PATH


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
alias cat='bat'

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
