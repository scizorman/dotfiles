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

# WSL2 specifics
if [[ $(uname -r) =~ 'microsoft' ]]; then
  export AWS_VAULT_BACKEND=pass
  export AWS_VAULT_PASS_PREFIX=aws-vault
fi

export GPG_TTY=$(tty)

# Go
export PATH=$HOME/sdk/go1.21.5/bin:$PATH
export GOPATH=${GOPATH:-$HOME/go}
export PATH="$GOPATH/bin:$PATH"

# Node
# Volta
export VOLTA_HOME=$HOME/.volta
export PATH=$VOLTA_HOME/bin:$PATH

# Deno
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH

# Bun
export BUN_INSTALL=$HOME/.bun
export PATH=$BUN_INSTALL/bin:$PATH

# Python
# Poetry
export PATH=$HOME/.poetry/bin:$PATH
export POETRY_VIRTUALENVS_IN_PROJECT=true

# rye
source $HOME/.rye/env

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Flutter
export PATH=$HOME/flutter/bin:$PATH

# ghq
export GHQ_ROOT=$HOME/ghq
