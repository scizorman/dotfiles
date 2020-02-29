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

# Initialize 'anyenv'
export ANYENV_ROOT="$HOME/.anyenv"
export ANYENV_DEFINITION_ROOT="$XDG_CONFIG_HOME/anyenv/anyenv-install"
export PATH="$HOME/.anyenv/bin:$PATH"

ANYENV_INIT_SOURCE="$ZDOTDIR/anyenv-init.zsh"
if [[ -e ${ANYENV_INIT_SOURCE} ]]; then
  ret=$(diff ${ANYENV_INIT_SOURCE} <(anyenv init -))
  [[ $ret != "" ]] && anyenv init - > ${ANYENV_INIT_SOURCE}
else
  anyenv init - > ${ANYENV_INIT_SOURCE}
fi
source ${ANYENV_INIT_SOURCE}

# Go
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Python
# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Scala
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export JAVA_HOME="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
