#!/bin/bash
# stop script if errors occure
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# get utilities
. "$DOTFILES_PATH/etc/lib/vital.sh"


# install formulas
if is_osx; then
  if has 'brew'; then
    brew update

    tapped_repos=$(brew tap)
    installed_formulas=$(brew list)

    # tap
    tap_repos=(
      beeftornado/rmtree
    )
    for repo in "${tap_repos[@]}"; do
      if echo "${tapped_repos[@]}" | grep -q "$repo"; then
        log_pass "$repo: Already tapped!"
      else
        if brew tap "$repo"; then
          log_pass "$repo: Tapped successfully!"
        else
          log_fail "$repo: Failed to tap"
          exit 1
        fi
      fi
    done

    # install formulas
    formulas=(
      brew-rmtree
      direnv
      # hadolint
      # mysql
      # shellcheck
      # the_platinum_searcher
      tree
    )

    for formula in "${formulas[@]}"; do
      if echo "${installed_formulas[@]}" | grep -q "$formula"; then
        log_pass "$formula: Already installed!"
      else
        if brew install "$formula"; then
          log_pass "$formula: Installed successfully!"
        else
          log_fail "$formula: Failed to install"
          exit 1
        fi
      fi
    done

    # Install universal-ctags
    # if echo "${installed_formulas}" | grep -q "universal-ctags"; then
    #   log_pass "universal-ctags: Already Installed!"
    # else
    #   if brew install --HEAD universal-ctags/universal-ctags/universal-ctags; then
    #     log_pass "universal-ctags: Installed successfully!"
    #   else
    #     log_fail "universal-ctags: Failed to install"
    #     exit 1
    #   fi
    # fi

    # update, Upgrade and cleanup
    brew update && brew upgrade && brew cleanup

  else
    log_fail 'Error: Homebrew is required'
    exit 1
  fi
else
  log_fail 'This script is only supported OSX'
  exit 1
fi
