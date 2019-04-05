#!/bin/bash
# Stop script if errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Python version
MAJOR=3
MINOR=7
BUILD=3
VERSION="$MAJOR.$MINOR.$BUILD"

# Install Python with pyenv
if [[ "$(python -V 2>&1)" =~ ^Python\ $VERSION$ ]]; then
  log_pass "Python ($VERSION): already installed"
else
  if has 'pyenv'; then
    log_echo "install Python ($VERSION) with pyenv"

    case "$(get_os)" in
      osx)
        if has 'brew'; then
          # Install requirements
          requirements=(
            openssl
            readline
            xz
          )

          log_echo 'install requirements with Homebrew'

          for requirement in "${requirements[@]}"; do
            log_echo "install $requirement with Homebrew"
            if brew install "$requirement"; then
              log_pass "$requirement: install successfully!"
            else
              log_fail "$requirement: failed to install"
              exit 1
            fi
          done

          # Install Python
          log_echo "install Python ($VERSION) with pyenv"
          if CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)" pyenv install "$VERSION"; then
            log_pass "Python ($VERSION): installed successfully!"
          else
            log_fail "Python ($VERSION): failed to install"
            exit 1
          fi

          # Set the installed Python global
          pyenv global $VERSION
          pyenv rehash

        else
          log_fail 'error: Homebrew is required'
          exit 1
        fi
        ;;
      *)
        log_fail 'error: this script is only supported OSX'
        exit 1
        ;;
    esac

  else
    log_fail 'error: pyenv is required'
    exit 1
  fi
fi

# Update pip
log_echo 'update pip'
if pip install -U pip; then
    log_pass 'pip: update successfully!'
  else
    log_echo 'pip: failed to update'
    exit 1
fi

# Install Pipenv
if [[ "$(pip -V 2>&1)"  =~ ^pip.*\(python\ $MAJOR.$MINOR\) ]]; then
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
