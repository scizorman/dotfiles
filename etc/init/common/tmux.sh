#!/bin/bash
# stop script i errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Tmux
if has 'tmux'; then
  log_pass 'Tmux: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'install Tmux with Homebrew'
        if brew install tmux reattach-to-user-namespace; then
          log_pass 'Tmux: installed successfully!'
        else
          log_fail 'Tmux: failed to install'
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

# install tpm (Tmux Plugin Manager)
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  log_pass 'tpm: already installed!'
else
  if [ ! -d "$HOME/.tmux/plugins" ]; then
    mkdir -p "$HOME/.tmux/plugins"
  fi

  if has 'git'; then
    log_echo 'install tpm with Git'
    if git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"; then
      log_pass 'tpm: installed successfully!'
    else
      log_fail 'tpm: failed to install'
      exit 1
    fi
  else
    log_fail 'error: Git is required'
    exit 1
  fi
fi
