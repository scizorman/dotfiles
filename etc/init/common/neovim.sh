#!/bin/bash
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH"/etc/lib/vital.sh

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
        log_fail "Error: Homebrew is required."
        exit 1
      fi
      ;;
    *)
      log_fail "Error: This script is only supported OSX."
      exit 1
      ;;
  esac
fi

# Install requirements for Neovim
if has 'pip3' || [[ "$(pip -V 2>&1)" =~ ^pip.*python\ 3\.[0-9] ]]; then
  req_path="$DOTFILES_PATH"/etc/lib/nvim/requirements.txt
  if [ ! -f "$req_path" ]; then
    log_fail "$req_path: Not found."
    exit 1
  fi

  if has 'pip3'; then
    pip_cmd="pip3 install -r $req_path"
  else
    pip_cmd="pip install -r $req_path"
  fi

  log_echo 'Install requirements of Python3 for Neovim with pip.'
  if eval ${pip_cmd}; then
    log_pass 'Python 3 provider (Neovim) and etc.: Install successfully!'
  else
    log_fail 'Python 3 provider (Neovim) and etc.: Failed to install.'
    exit 1
  fi
else
  log_fail 'Error: pip (Python3) is required.'
  exit 1
fi
