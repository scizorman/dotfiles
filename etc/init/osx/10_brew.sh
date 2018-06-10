#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/init/assets/vital.sh

if ! is_osx; then
    log_fail "Error: This script is only supported OSX."
    exit 1
fi

# Install Homebrew
if ! has "brew"; then
    # Homebrew is dependent on 'xcode-select'.
    if xcode-select --install >/dev/null 2>&1; then
        log_info "Install 'xcode-select'."
        xcode-select --install
        log_pass "xcode-select: Installed successfully."
    else
        log_pass "xcode-select: Already exists."
    fi

    if ! has "ruby"; then
        log_fail "Error: Ruby is required."
        exit 1
    fi

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    if has "brew"; then
        brew doctor
    else
        log_fail "Error: Failed to install Homebrew."
        exit 1
    fi
fi

log_pass "Homebrew: Installed successfully."
