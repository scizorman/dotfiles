#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH"/etc/lib/vital.sh


# Install formulas
if is_osx; then
  if has 'brew'; then
    formulas=(
      autoconf
      beeftornado/rmtree/brew-rmtree
      mysql
      pkg-config
      tree
    )

    # Tap
    if brew tap beeftornado/rmtree >/dev/null 2>&1; then
      log_pass 'beeftornado/rmtree: Tapped successfully!'
    else
      log_fail 'beeftornado/rmtree: Failed to tap.'
      exit 1
    fi

    # Install formulas
    brew update
    for formula in "${formulas[@]}"; do
      if [ -e /usr/local/Cellar/"$formula" ]; then
        log_pass "$formula: Already installed!"
      else
        if brew install "$formula" >/dev/null 2>&1; then
          log_pass "$formula: Installed successfully!"
        else
          log_fail "$formula: Failed to install."
          exit 1
        fi
      fi
    done

    # Upgrade and cleanup
    brew upgrade
    brew cleanup

  else
    log_fail 'Error: Homebrew is required.'
    exit 1
  fi
else
  log_fail 'This script is only supported OSX.'
  exit 1
fi
