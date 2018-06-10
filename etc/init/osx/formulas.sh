#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' HUP INT QUIT TERM
set -eu

# Get utilities
. "$DOTPATH"/etc/init/assets/vital.sh

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
    if [ ! -e /usr/local/Cellar/"$formula" ]; then
        brew install $formula
    else
        log_info "Homebrew: $formula: Already exists."
    fi
done

for cask_formula in "${cask_formulas[@]}"; do
    if [ ! -e /usr/local/Caskroom/"$cask_formula" ]; then
        brew cask install $cask_formula
    else
        log_info "Homebrew: $cask_formula: Already exists."
    fi
done

# Upgrade and cleanup.
brew upgrade
brew cleanup
brew cask cleanup

log_pass "Installed formulas successfully."
