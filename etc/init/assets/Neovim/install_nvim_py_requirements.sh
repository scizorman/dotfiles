#!/bin/sh
# Stop script if errors occure.
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Get utilities
. "$DOTPATH"/etc/vital.sh

if ! has "pip2"; then
    log_fail "Error: 'pip' (for Python2.7) is required."
    exit 1
fi

if ! has "pip3"; then
    log_fail "Error: 'pip' (for the latest version of Python) is required."
    exit 1
fi

# Install Python2.7 packages
log_echo "Install packages (Python2.7) for Neovim."
pip2 install -r $DOTPATH/etc/init/assets/Neovim/nvim_py2_requirements.txt

# Install Python (the latest version) packages
log_echo "Install packages (the latest version of Python) for Neovim."
pip3 install -r $DOTPATH/etc/init/assets/Neovim/nvim_py3_requirements.txt

log_pass "Packages (Python) for Neovim: Installed successfully."
