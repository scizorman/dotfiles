#!/bin/sh
if ["$(uname)" == 'Darwin']; then
  $HOME/.dotfiles/etc/setup/brew.sh
elif ["$(expr substr $(uname -s) 1 5)" == 'Linux']; then
  $HOME/.dotfiles/etc/setup/apt.sh
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
