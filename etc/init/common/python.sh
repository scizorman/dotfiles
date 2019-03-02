#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Python version (latest)
major=3
minor=7
build=2

# Install pyenv
if has 'pyenv' || [ -d "$HOME/.pyenv" ]; then
  log_pass 'pyenv: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install pyenv with Homebrew'
        if brew install pyenv; then
          log_pass 'pyenv: Installed successfully!'
        else
          log_fail 'pyenv: Failed to install.'
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

# Install Python (latest) with pyenv
if [[ "$(python -V 2>&1)" =~ ^Python\ $major.$minor.$build$ ]]; then
  log_pass 'Python (latest): Already installed'
else
  if has 'pyenv'; then
    log_echo 'Install Python (latest) with pyenv'

    # Initialize pyenv
    export PYENV_ROOT='/usr/local/var/pyenv'
    eval "$(pyenv init -)"

    if pyenv install $major.$minor.$build; then
      log_pass 'Python (latest): Installed successfully!'
    else
      log_fail 'Python (latest): Failed to install.'
      exit 1
    fi

    # Set the installed python global
    pyenv rehash
    pyenv global $major.$minor.$build

  else
    log_fail 'Error: pyenv is required.'
    exit 1
  fi
fi

# Install Pipenv
if [[ "$(pip -V 2>&1)"  =~ ^pip.*\(python\ $major.$minor\) ]]; then
  # Update pip
  if pip install -U pip; then
    log_pass 'pip: Update successfully!'
  else
    log_echo 'pip: Failed to update.'
    exit 1
  fi

  if has 'pipenv'; then
    log_pass 'Pipenv: Already installed!'
  else
    log_echo 'Install Pipenv'
    if pip install pipenv; then
      log_pass 'Pipenv: Install successfully!'
    else
      log_fail 'Pipenv: Failed to install'
      exit 1
    fi
  fi
else
  log_fail 'Error: pip is required.'
  exit 1
fi
