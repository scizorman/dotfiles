#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Neovim
if has 'nvim'; then
  log_pass 'Neovim: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo "Install Neovim with Homebrew"
        if brew install neovim; then
          log_pass 'Neovim: Installed successfully!'
        else
          log_fail 'Neovim: Failed to install'
          exit 1
        fi
      else
        log_fail 'Error: Homebrew is required'
        exit 1
      fi
      ;;
    *)
      log_fail 'Error: This script is only supported OSX'
      exit 1
      ;;
  esac
fi

# install Python3 provider
if has 'pip'; then
  if pip show pynvim > /dev/null; then
    log_pass 'Python3 provider: Already installed!'
  else
    log_echo "Install Python3 provider with pip"
    if pip install pynvim; then
      log_pass 'Python3 provider: Installed successfully!'
    else
      log_fail 'Python3 provider: Failed to install'
      exit 1
    fi
  fi
else
  log_fail 'Error: pip is required'
  exit 1
fi

# install LSPs (Language Server Protocol)
# golsp
if has 'golsp'; then
  log_pass 'golsp: Already installed!'
else
  log_echo 'Install golsp with go'
  if has 'go'; then
    if go get -u golang.org/x/tools/cmd/golsp; then
      log_pass 'golsp: Installed successfully!'
    else
      log_fail 'golsp: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: Go is required'
    exit 1
  fi
fi

# pyls
if has 'pyls'; then
  log_pass 'pyls: Already installed!'
else
  if has 'pip'; then
    log_echo 'Install pyls with pip'
    if pip install python-language-server; then
      log_pass 'pyls: Installed successfully!'
    else
      log_fail 'pyls: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: pip is required'
    exit 1
  fi
fi

# vls
if has 'vls'; then
  log_pass 'vls: Already installed!'
else
  if has 'npm'; then
    log_echo 'Install vls with npm'
    if npm install -g vue-language-server; then
      log_pass 'vls: Installed successfully!'
    else
      log_fail 'vls: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: npm is required'
    exit 1
  fi
fi
