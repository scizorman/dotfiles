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
