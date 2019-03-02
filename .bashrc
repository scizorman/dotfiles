#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[ -n "$VIMRUNTIME" ] && return

# Functions
is_exists() {
  command -v "$1" >/dev/null 2>&1
  return $?
}

has() {
  is_exists "$@"
}

# Go
if has goenv; then
  export GOENV_ROOT="/usr/local/var/goenv"
  eval "$(goenv init -)"

  GO_VERSION="$(goenv version | sed 's/.(.*)$//')"
  export GOROOT="$GOENV_ROOT/versions/$GO_VERSION"
fi

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
if has pyenv; then
  export PYENV_ROOT="/usr/local/var/pyenv"
  eval "$(pyenv init -)"
fi

# Node.js
if has nodenv; then
  export NODENV_ROOT="/usr/local/var/nodenv"
  eval "$(nodenv init -)"
fi
