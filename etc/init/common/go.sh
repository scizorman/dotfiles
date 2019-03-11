#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Golang version
major=1
minor=11
build=4
version="$major.$minor.$build"

# Install goenv
if has 'goenv' || [ -d "$HOME/.goenv" ]; then
  log_pass 'goenv: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install goenv with Homebrew'
        if brew install goenv; then
          log_pass 'goenv: Installed successfully!'
        else
          log_fail 'goenv: Failed to install'
          exit 1
        fi
      else
        log_fail 'Error: Homebrew is required'
        exit 1
      fi
      ;;
    *)
      log_fail 'Error: This script only supported OSX'
      exit 1
      ;;
  esac
fi

# Install Golang with goenv
if [[ "$(go version 2>&1)" =~ ^go\ version\ go$major.$minor.*$ ]]; then
  log_pass "Golang ($version): Already installed!"
else
  if has 'goenv'; then
    log_echo "Install Golang ($version) with goenv"

    # Initialize goenv
    export GOENV_ROOT="/usr/local/var/goenv"
    eval "$(goenv init -)"

    if goenv install $version; then
      log_pass "Golang ($version): Installed successfully!"
    else
      log_fail "Golang ($version): Failed to install"
      exit 1
    fi

    # Set the installed go global
    goenv rehash
    goenv global $version

  else
    log_fail 'Error: goenv is required'
    exit 1
  fi
fi
