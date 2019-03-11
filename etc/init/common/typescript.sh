#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Install TypeScript
if has 'tsc'; then
  log_pass 'TypeScript: Already installed!'
else
  if has 'npm'; then
    log_echo 'Install TypeScript with npm'
    if npm install -g typescript; then
      log_pass 'TypeScript: Installed successfully!'
    else
      log_fail 'TypeScript: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: npm is required'
    exit 1
  fi
fi
