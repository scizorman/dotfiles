#!/bin/bash
# stop script if errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Zsh
if has 'zsh'; then
  log_pass 'Zsh: already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'install Zsh with Homebrew'
        if brew install zsh; then
          log_pass 'Zsh: installed successfully!'
        else
          log_fail 'Zsh: failed to install'
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

# Install Zplugin
if has 'zplugin' || [ -d "${ZDOTDIR:-$HOME/.zsh}/.zplugin" ]; then
  log_pass 'Zplugin: already installed!'
else
  if has 'git'; then
    log_echo 'install Zplugin with Git'

    ZPLUGIN_URL='https://github.com/zdharma/zplugin'

    if git clone $ZPLUGIN_URL $ZDOTDIR/.zplugin; then
      log_pass 'Zplugin: install successfully!'
    else
      log_fail 'Zplugin: failed to install'
      exit 1
    fi
  else
    log_fail 'error: Git is required'
    exit 1
  fi
fi

# run the forced termination with a last exit code
# exit $?

# Assign Zsh as a login shell
if ! contains "$SHELL:-" 'zsh'; then
  zsh_path="$(command -v zsh)"

  # Check /etc/shells
  if ! grep -xq "${zsh_path:=/bin/zsh}" /etc/shells; then
    log_fail "oh, you should append '$zsh_path' to '/etc/shells'"
    exit 1
  fi

  if [ -x "$zsh_path" ]; then
    # Changing for a general user
    if chsh -s "$zsh_path" "${USER:-root}"; then
      log_pass "change shell to '$zsh_path' for ${USER:-root} successfully!"
    else
      log_fail "cannot set '$zsh_path' as \$SHELL"
      log_fail "is '$zsh_path' described in 'etc/shells'?"
      log_fail 'you should run "chsh -l" now'
      exit 1
    fi

    # For root user
    if [ ${EUID:-${UID}} == 0 ]; then
      if chsh -s "$zsh_path" && :; then
        log_pass "[root] change shell to '$zsh_path' successfully!"
      fi
    fi
  else
    log_fail "$zsh_path: invalid path"
    exit 1
  fi
fi
