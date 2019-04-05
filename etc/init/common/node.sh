#!/bin/bash
# Stop script if errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Node.js version (stable)
MAJOR=10
MINOR=15
BUILD=3
VERSION="$MAJOR.$MINOR.$BUILD"

# Install Node.js with nodenv
if [[ "$(node -v 2>&1)" =~ ^v$VERSION$ ]]; then
  log_pass "Node.js ($VERSION): already installed!"
else
  if has 'nodenv'; then
    log_echo "install Node.js ($VERSION) with nodenv"

    # Initialize nodenv
    if nodenv install $VERSION; then
      log_pass "Node.js ($VERSION): installed successfully!"
    else
      log_fail "Node.js ($VERSION): failed to install"
      exit 1
    fi

    # Set the installed node.js global
    nodenv global $VERSION
    nodenv rehash

  else
    log_fail 'error: nodenv is required'
    exit 1
  fi
fi

# Update npm
log_echo 'update npm'
if npm install -g npm; then
  log_pass 'npm: update successfully!'
else
  log_fail 'npm: failed to update'
  exit 1
fi
