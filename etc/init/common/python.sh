#!/bin/bash
# stop script if errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# python version
major=3
minor=7
build=2
version="$major.$minor.$build"

# install pyenv
if has 'pyenv' || [ -d "$HOME/.pyenv" ]; then
  log_pass 'pyenv: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'install pyenv with Homebrew'
        if brew install pyenv; then
          log_pass 'pyenv: installed successfully!'
        else
          log_fail 'pyenv: failed to install'
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

# install Python with pyenv
if [[ "$(python -V 2>&1)" =~ ^Python\ $version$ ]]; then
  log_pass "Python ($version): already installed"
else
  if has 'pyenv'; then
    log_echo "install Python ($version) with pyenv"

    # initialize pyenv
    export PYENV_ROOT='/usr/local/var/pyenv'
    eval "$(pyenv init -)"

    if pyenv install $version; then
      log_pass "Python ($version): installed successfully!"
    else
      log_fail "Python ($version): failed to install"
      exit 1
    fi

    # set the installed python global
    pyenv rehash
    pyenv global $version

  else
    log_fail 'error: pyenv is required'
    exit 1
  fi
fi

# update pip
log_echo 'update pip'
if pip install -U pip; then
    log_pass 'pip: update successfully!'
  else
    log_echo 'pip: failed to update'
    exit 1
fi

# install Pipenv
if [[ "$(pip -V 2>&1)"  =~ ^pip.*\(python\ $major.$minor\) ]]; then
  if has 'pipenv'; then
    log_pass 'Pipenv: already installed!'
  else
    log_echo 'install Pipenv'
    if pip install pipenv; then
      log_pass 'Pipenv: install successfully!'
    else
      log_fail 'Pipenv: failed to install'
      exit 1
    fi
  fi
else
  log_fail 'error: pip is required'
  exit 1
fi
