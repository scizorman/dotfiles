#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Golang version
MAJOR=1
MINOR=12
BUILD=5
VERSION="$MAJOR.$MINOR.$BUILD"

# Install Golang with goenv
if [[ "$(go version 2>&1)" =~ ^go\ version\ go$MAJOR.$MINOR.*$ ]]; then
  log_pass "Golang ($VERSION): already installed!"
else
  if has 'goenv'; then
    log_echo "install Golang ($VERSION) with goenv"

    # Initialize goenv
    if goenv install $VERSION; then
      log_pass "Golang ($VERSION): installed successfully!"
    else
      log_fail "Golang ($VERSION): failed to install"
      exit 1
    fi

    # Set the installed go global
    goenv global $VERSION
    goenv rehash

  else
    log_fail 'error: goenv is required'
    exit 1
  fi
fi
