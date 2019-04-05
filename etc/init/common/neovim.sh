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
