#!/bin/bash
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Install Neovim
if has 'nvim'; then
  log_pass 'Neovim: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo "Install Neovim with Homebrew."
        if brew install neovim; then
          log_pass 'Neovim: Installed successfully!'
        else
          log_fail 'Neovim: Failed to install.'
          exit 1
        fi
      else
        log_fail 'Error: Homebrew is required.'
        exit 1
      fi
      ;;
    *)
      log_fail 'Error: This script is only supported OSX.'
      exit 1
      ;;
  esac
fi

# Install Python3 provider
if has 'pip'; then
  if pip show pynvim > /dev/null; then
    log_pass 'Python3 provider: Already installed!'
  else
    log_echo "Install Python3 provider with pip."
    if pip install pynvim; then
      log_pass 'Python3 provider: Installed successfully!'
    else
      log_fail 'Python3 provider: Failed to install.'
      exit 1
    fi
  fi
else
  log_fail 'Error: pip is required.'
  exit 1
fi

# Install Node.js provider
if has 'npm'; then
  if npm list -g neovim > /dev/null; then
    log_pass 'Node.js provider: Already installed!'
  else
    log_echo "Install Node.js provider with npm."
    if npm install -g neovim; then
      log_pass 'Node.js provider: Install successfully!'
    else
      log_fail 'Node.js provider: Failed to install.'
      exit 1
    fi
  fi
else
  log_fail 'Error: npm is required.'
  exit 1
fi
