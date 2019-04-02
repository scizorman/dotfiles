#!/bin/bash
# stop script i errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Tmux
if has 'tmux'; then
  log_pass 'Tmux: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install Tmux with Homebrew'
        if brew install tmux reattach-to-user-namespace; then
          log_pass 'Tmux: Installed successfully!'
        else
          log_fail 'Tmux: Failed to install'
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

# install tpm (Tmux Plugin Manager)
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  log_pass 'tpm: Already installed!'
else
  if [ ! -d "$HOME/.tmux/plugins" ]; then
    mkdir -p "$HOME/.tmux/plugins"
  fi

  if has 'git'; then
    log_echo 'Install tpm with Git'
    if git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"; then
      log_pass 'tpm: Installed successfully!'
    else
      log_fail 'tpm: Failed to install'
      exit 1
    fi
  else
    log_fail 'Error: Git is required'
    exit 1
  fi
fi
