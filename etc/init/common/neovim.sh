#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Neovim
if has 'nvim'; then
  log_pass 'Neovim: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo "install Neovim with Homebrew"
        if brew install neovim; then
          log_pass 'Neovim: installed successfully!'
        else
          log_fail 'Neovim: failed to install'
          exit 1
        fi
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
fi

# install Python3 provider
if has 'pip'; then
  if pip show pynvim > /dev/null; then
    log_pass 'Python3 provider: Already installed!'
  else
    log_echo "install Python3 provider with pip"
    if pip install pynvim; then
      log_pass 'Python3 provider: installed successfully!'
    else
      log_fail 'Python3 provider: failed to install'
      exit 1
    fi
  fi
else
  log_fail 'error: pip is required'
  exit 1
fi

# install LSPs (Language Server Protocol)
# golsp
if has 'golsp'; then
  log_pass 'golsp: already installed!'
else
  log_echo 'install golsp with go'
  if has 'go'; then
    if go get -u golang.org/x/tools/cmd/golsp; then
      log_pass 'golsp: installed successfully!'
    else
      log_fail 'golsp: failed to install'
      exit 1
    fi
  else
    log_fail 'error: Go is required'
    exit 1
  fi
fi

# pyls
if has 'pyls'; then
  log_pass 'pyls: already installed!'
else
  if has 'pip'; then
    log_echo 'install pyls with pip'
    if pip install python-language-server; then
      log_pass 'pyls: installed successfully!'
    else
      log_fail 'pyls: failed to install'
      exit 1
    fi
  else
    log_fail 'error: pip is required'
    exit 1
  fi
fi

# vls
if has 'vls'; then
  log_pass 'vls: already installed!'
else
  if has 'npm'; then
    log_echo 'install vls with npm'
    if npm install -g vue-language-server; then
      log_pass 'vls: installed successfully!'
    else
      log_fail 'vls: failed to install'
      exit 1
    fi
  else
    log_fail 'error: npm is required'
    exit 1
  fi
fi
