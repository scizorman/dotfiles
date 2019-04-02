#!/bin/bash
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Homebrew
if is_osx; then
  if has 'brew'; then
    log_pass 'Homebrew: already installed!'
  else
    if has 'ruby' && has 'curl'; then
      log_echo 'install Homebrew with Ruby'
      if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; then
        log_pass 'Homebrew: installed successfully!'
      else
        log_fail 'Homebrew: failed to install'
        exit 1
      fi
    else
      log_fail 'error: Ruby and cURL are required'
      exit 1
    fi
    brew doctor
  fi
else
  log_fail 'this script is supported only OSX'
  exit 1
fi
