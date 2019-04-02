#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Git
if has 'git'; then
  log_pass 'Git: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'install Git with Homebrew'
        if brew install git; then
          log_pass 'Git: install successfully!'
        else
          log_fail 'Git: failed to install'
          exit 1
        fi
      else
        log_fail 'error: homebrew is required'
        exit 1
      fi
      ;;
    *)
      log_fail 'error: this script is only supported OSX'
      exit 1
      ;;
  esac
fi
