#!/usr/bin/env bash
# if not running interactively, don't do anything
[ -z "$PS1" ] && return
[ -n "$VIMRUNTIME" ] && return

# functions
is_exists() {
  command -v "$1" >/dev/null 2>&1
  return $?
}

has() {
  is_exists "$@"
}


# Initialize `anyenv`
eval "$(anyenv init -)"

# Go
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$PATH"
