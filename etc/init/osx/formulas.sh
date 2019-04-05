#!/bin/bash
# Stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"


# Install formulas
if is_osx; then
  if has 'brew'; then
    brew update

    tapped_repos=$(brew tap)
    installed_formulas=$(brew list)

    # Tap repositoried
    tap_repos=(
      beeftornado/rmtree
    )
    for repo in "${tap_repos[@]}"; do
      if echo "${tapped_repos[@]}" | grep -q "$repo"; then
        log_pass "$repo: already tapped!"
      else
        if brew tap "$repo"; then
          log_pass "$repo: tapped successfully!"
        else
          log_fail "$repo: failed to tap"
          exit 1
        fi
      fi
    done

    # Install formulas
    formulas=(
      brew-rmtree
      terraform
    )

    for formula in "${formulas[@]}"; do
      if echo "${installed_formulas[@]}" | grep -q "$formula"; then
        log_pass "$formula: already installed!"
      else
        if brew install "$formula"; then
          log_pass "$formula: installed successfully!"
        else
          log_fail "$formula: failed to install"
          exit 1
        fi
      fi
    done

    # Update, Upgrade and cleanup
    brew update && brew upgrade && brew cleanup

  else
    log_fail 'error: Homebrew is required'
    exit 1
  fi
else
  log_fail 'this script is only supported OSX'
  exit 1
fi
