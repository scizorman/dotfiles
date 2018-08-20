#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH"/etc/lib/vital.sh

# Install Golang
if has 'go'; then
  log_pass 'Golang: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install Golang with Homebrew.'
        if brew install go; then
          log_pass 'Golang: Installed successfully!'
        else
          log_fail 'Golang: Failed to install.'
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
