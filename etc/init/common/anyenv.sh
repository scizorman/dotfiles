#!/bin/bash
# Stop script if errors occure
trap 'echo error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"

# Envs to install
envs=(
  goenv
  pyenv
  nodenv
)

# Install 'anyenv'
if has 'anyenv' || [ -d "$HOME/.anyenv" ]; then
  log_pass 'anyenv: already installed!'
else
  export ANYENV_ROOT="$HOME/.anyenv"
  export ANYENV_DEFINITION_ROOT="$HOME/.config/anyenv/anyenv-install"

  if has 'git'; then
    log_echo 'install anyenv with Git'

    ANYENV_URL="https://github.com/anyenv/anyenv"

    # Install
    if git clone "$ANYENV_URL" "$ANYENV_ROOT"; then
      log_pass 'anyenv: installed successfully!'
    else
      log_fail 'anyenv: failed to install'
      exit 1
    fi

    # Initialize
    export PATH="$ANYENV_ROOT/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install --init

    # Install Envs
    for env in "${env[@]}"; do
      if has "$env"; then
        log_pass "$env: already installed!"
      else
        log_echo "install $env with anyenv"
        if anyenv install "$env"; then
          log_pass "$env: installed successfully!"
        else
          log_fail "$env: failed to install"
          exit 1
        fi
      fi
    done

  else
    log_fail 'error: Git is required'
    exit 1
  fi
fi

# Initialize
eval "$(anyenv init -)"

# Install languages
. "$DOTFILES_PATH/etc/init/common/go.sh"
. "$DOTFILES_PATH/etc/init/common/python.sh"
. "$DOTFILES_PATH/etc/init/common/node.sh"

# Reinitialize
eval "$(anyenv init -)"
