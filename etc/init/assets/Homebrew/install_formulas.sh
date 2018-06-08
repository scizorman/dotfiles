#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

if ! has "brew"; then
    log_fail "Error: Homebrew is required."
    exit 1
fi

formulas=(
    autoconf
    homebrew/cask-fonts/font-ricty-diminished
    jpeg
    libtiff
    little-cms2
    mas
    mysql
    neovim
    openssl
    optipng
    pkg-config
    python3
    reattach-to-user-namespace
    tree
    "vim --with-lua" 
)

cask_formulas=(
    alfred
    appcleaner
    cheatsheet
    docker
    dropbox
    google-chrome
    google-japanese-ime
    iterm2
    mysqlworkbench
    skype
    slack
)

# Tap
brew tap caskroom/fonts

# Install formulas
brew update

for formula in "${formulas[@]}"; do
    brew install $formula
done

for cask_formula in "${cask_formulas[@]}"; do
    brew cask install $cask_formula
done

# Upgrade and cleanup.
brew upgrade
brew cleanup
brew cask cleanup

log_pass "Installed formulas successfully."
