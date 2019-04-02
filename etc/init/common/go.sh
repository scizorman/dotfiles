#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Golang version
major=1
minor=11
build=4
version="$major.$minor.$build"

# install goenv
if has 'goenv' || [ -d "$HOME/.goenv" ]; then
  log_pass 'goenv: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'install goenv with Homebrew'
        if brew install goenv; then
          log_pass 'goenv: installed successfully!'
        else
          log_fail 'goenv: failed to install'
          exit 1
        fi
      else
        log_fail 'error: Homebrew is required'
        exit 1
      fi
      ;;
    *)
      log_fail 'error: this script only supported OSX'
      exit 1
      ;;
  esac
fi

# install Golang with goenv
if [[ "$(go version 2>&1)" =~ ^go\ version\ go$major.$minor.*$ ]]; then
  log_pass "Golang ($version): already installed!"
else
  if has 'goenv'; then
    log_echo "install Golang ($version) with goenv"

    # initialize goenv
    export GOENV_ROOT="/usr/local/var/goenv"
    eval "$(goenv init -)"

    if goenv install $version; then
      log_pass "Golang ($version): installed successfully!"
    else
      log_fail "Golang ($version): failed to install"
      exit 1
    fi

    # set the installed go global
    goenv rehash
    goenv global $version

  else
    log_fail 'error: goenv is required'
    exit 1
  fi
fi
