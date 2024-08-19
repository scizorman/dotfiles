#!/usr/bin/env zsh
# PATH
typeset -gxU path PATH
path=( \
  $HOME/bin(N-/) \
  $HOME/.local/bin \
  /usr/local/bin \
  $path \
)

# Linux specifics
if [[ $(uname) == 'Linux' ]]; then
  # Homebrew
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# macOS specifics
if [[ $(uname) == 'Darwin' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # GNU toolchain
  path=("${HOMEBREW_PREFIX}/opt/*/libexec/gnubin" $path)
  manpath=("${HOMEBREW_PREFIX/opt/*/libexec/gnuman}" $manpath)

  # SnowSQL
  export PATH="/Applications/SnowSQL.app/Contents/MacOS:${PATH}"
fi

# WSL2 specifics
if [[ $(uname -r) =~ 'microsoft' ]]; then
  export AWS_VAULT_BACKEND=pass
  export AWS_VAULT_PASS_PREFIX=aws-vault
fi

export GPG_TTY=$(tty)

# PostgreSQL client
export PATH="${HOMEBREW_PREFIX}/opt/libpq/bin":$PATH

# MySQL client
export PATH="${HOMEBREW_PREFIX}/opt/mysql-client/bin":$PATH

# Go
export PATH=$HOME/sdk/go1.23.0/bin:$PATH
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
