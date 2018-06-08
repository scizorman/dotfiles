#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

if ! is_osx; then
    log_fail "Error: This script is only supported OSX."
    exit 1
fi

if has "brew"; then
    log_pass "brew: Already installed."
    exit
fi

# Homebrew is dependent on 'xcode-select'.
if xcode-select --install >/dev/null 2>&1; then
    log_info "Install 'xcode-select'."
    xcode-select --install
    log_pass "xcode-select: Installed successfully."
else
    log_pass "xcode-select: Already installed."
fi

if ! has "ruby"; then
    log_fail "Error: 'ruby' is required."
    exit 1
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if has "brew"; then
    brew doctor
else
    log_fail "Error: Failed to install Homebrew."
    exit 1
fi

log_pass "brew: Installed successfully."
