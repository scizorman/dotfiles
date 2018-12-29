#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Node.js version (stable)
NODE_VERSION=10.15.0

# Install nodebrew
if has 'nodebrew'; then
  log_pass 'nodebrew: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install nodebrew with Homebrew'
        if brew install nodebrew; then
          log_pass 'nodebrew: Installed successfully!'

          # Initialize nodebrew
          export NODEBREW_ROOT='/usr/local/var/nodebrew'
          nodebrew setup_dirs
        else
          log_fail 'nodebrew: Faild to install.'
          exit 1
        fi
      else
        log_fail 'Error: Homebrew is required.'
        exit 1
      fi
      ;;
    *)
      log_fail 'Error: This script only supported OSX.'
      exit 1
      ;;
    esac
fi

# Install Node.js (stable) with nodebrew
if has 'node'; then
  log_pass 'Node.js (stable): Already installed!'
else
  # Set path for nodebrew
  if has 'nodebrew'; then
    log_echo 'Install Node.js (stable) with nodebrew'
    if nodebrew install-binary $NODE_VERSION; then
      log_pass 'Node.js (stable): Installed successfully!'

      # Initialize npm
      export PATH="$NODEBREW_ROOT/current/bin:$PATH"
      nodebrew use $NODE_VERSION
    else
      log_fail 'Node.js (stable): Failed to install.'
      exit 1
    fi
  else
    log_fail 'Error: nodebrew is required.'
    exit 1
  fi
fi
