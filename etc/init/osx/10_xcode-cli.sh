#!/bin/bash
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTFILES_PATH"/etc/lib/vital.sh

# Install Xcode-CLI
if is_osx; then
  if xcode-select --install >/dev/null 2>&1; then
    log_info 'Install Xcode-CLI.'
    xcode-select --install
    log_pass 'Xcode-CLI: Installed successfully!'
  else
    log_pass 'Xcode-CLI: Already installed!'
  fi
else
  log_fail 'Error: This script supported only OSX.'
  exit 1
fi
