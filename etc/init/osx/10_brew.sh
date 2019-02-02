#!/bin/bash
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Install Homebrew
if is_osx; then
  if has 'brew'; then
    log_pass 'Homebrew: Already installed!'
    exit
  else
    if has 'ruby'; then
      if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; then
        log_pass 'Homebrew: Installed successfully!'
      else
        log_fail 'Homebrew: Failed to install.'
        exit 1
      fi
      brew doctor
    else
      log_fail 'Error: Ruby is required.'
      exit 1
    fi
  fi
else
  log_fail 'This script is supported only OSX.'
  exit 1
fi
