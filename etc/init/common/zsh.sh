#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# install Zsh
if has 'zsh'; then
  log_pass 'Zsh: Already installed!'
else
  case "$(get_os)" in
    osx)
      if has 'brew'; then
        log_echo 'Install Zsh with Homebrew'
        if brew install zsh; then
          log_pass 'Zsh: Installed successfully!'
        else
          log_fail 'Zsh: Failed to install'
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

# install zplug
if has 'zplug' || [ -d "$HOME/.zplug" ]; then
  log_pass 'zplug: Already installed!'
else
  if has 'curl'; then
    log_echo 'Install zplug with cURL'
    if curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; then
      log_pass 'zplug: Install successfully!'
    else
      log_fail 'zplug: Failed to install'
      exit 1
    fi
  elif has 'git'; then
    log_echo 'Install zplug with Git'
    if git clone https://github.com/zplug/zplug ~/.zplug; then
      log_pass 'zplug: Install successfully!'
    else
      log_fail 'zplug: Failed to install'
      exit 1
    fi
  fi
fi

# run the forced termination with a last exit code
# exit $?

# Assign Zsh as a login shell
if ! contains "$SHELL:-" 'zsh'; then
  zsh_path="$(command -v zsh)"

  # Check /etc/shells
  if ! grep -xq "${zsh_path:=/bin/zsh}" /etc/shells; then
    log_fail "Oh, you should append '$zsh_path' to '/etc/shells'"
    exit 1
  fi

  if [ -x "$zsh_path" ]; then
    # Changing for a general user
    if chsh -s "$zsh_path" "${USER:-root}"; then
      log_pass "Change shell to '$zsh_path' for ${USER:-root} successfully!"
    else
      log_fail "Cannot set '$zsh_path' as \$SHELL"
      log_fail "Is '$zsh_path' described in 'etc/shells'?"
      log_fail 'You should run "chsh -l" now'
      exit 1
    fi

    # For root user
    if [ ${EUID:-${UID}} == 0 ]; then
      if chsh -s "$zsh_path" && :; then
        log_pass "[root] Change shell to '$zsh_path' successfully!"
      fi
    fi
  else
    log_fail "$zsh_path: Invalid path"
    exit 1
  fi
fi
