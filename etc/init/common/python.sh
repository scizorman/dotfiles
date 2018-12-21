#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH"/etc/lib/vital.sh

# Python version (latest)
major=3
minor=7
build=1

# Install pyenv
if has 'pyenv'; then
  log_pass 'pyenv: Already installed!'
else
  if has 'git'; then
    log_echo 'Install pyenv with Git'
    if git clone git://github.com/yyuu/pyenv.git "$HOME/.pyenv"; then
      log_pass 'pyenv: Installed successfully!'
    else
      log_fail 'pyenv: Failed to install.'
      exit 1
    fi
  else
    log_fail 'Error: Git is required.'
    exit 1
  fi
fi

# Install Python (latest) with pyenv
if [[ "$(python -V 2>&1)" =~ ^Python\ $major.$minor.$build$ ]]; then
  log_pass 'Python (latest): Already installed'
else
  # Set path for pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if has 'pyenv'; then
    log_echo 'Install Python (latest) with pyenv'
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

# Install Python package
if [[ "$(pip -V 2>&1)"  =~ ^pip.*\(python\ $major.$minor\) ]]; then
  req_path="$DOTFILES_PATH"/etc/lib/requirements.txt
  if [ ! -f "$req_path" ]; then
    log_fail "$req_path: Not found."
    exit 1
  fi

  log_echo 'Install requirements of Python3 with pip.'
  if pip install -r "$req_path"; then
    log_pass 'Python packages: Install successfully!'
  else
    log_fail 'Python packages: Install successfully!'
    exit 1
  fi
else
  log_fail 'Error: pip is required.'
  exit 1
fi
