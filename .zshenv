#!/usr/bin/env zsh
# Do not run the startup files /etc/zshenv, /etc/zprofile, ...
setopt no_global_rcs

# Directory of the startup files
export ZDOTDIR="$HOME/.zsh"

# Source setting files
source "$ZDOTDIR/.zsh"
