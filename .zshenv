#!/usr/bin/env zsh
# Do not run the startup files /etc/zshenv, /etc/zprofile, ...
unsetopt global_rcs

# Directory of the startup files
export ZDOTDIR="${HOME}/.zsh"

# Source setting files
[[ -f "${ZDOTDIR}/.zshenv" ]] && source "${ZDOTDIR}/.zshenv"
