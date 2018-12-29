#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Install golsp
if has 'golsp'; then
  log_pass 'golsp: Already installed!'
else
  log_echo 'Install golsp with go'
  if has 'go'; then
    if go get -u golang.org/x/tools/cmd/golsp; then
      log_pass 'golsp: Installed successfully!'
    else
      log_fail 'golsp: Failed to install.'
      exit 1
    fi
  else
    log_fail 'Error: Go is required.'
    exit 1
  fi
fi

# Install pyls
if has 'pyls'; then
  log_pass 'pyls: Already installed!'
else
  if has 'pip'; then
    log_echo 'Install pyls with pip'
    if pip install python-language-server; then
      log_pass 'pyls: Installed successfully!'
    else
      log_fail 'pyls: Failed to install.'
      exit 1
    fi
  else
    log_fail 'Error: pip is required.'
    exit 1
  fi
fi
