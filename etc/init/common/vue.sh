#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Vue.js
if has 'vue'; then
  log_pass 'Vue.js: Already installed!'
else
  if has 'npm'; then
    log_echo 'Install Vue.js with npm'
    if npm install -g @vue/cli; then
      log_pass 'Vue.js: Installed successfully!'
    else
      log_fail 'Vue.js: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: npm is required'
    exit 1
  fi
fi
