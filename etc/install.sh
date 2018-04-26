#!/bin/sh
if ["$(uname)" == 'Darwin']; then
  $HOME/.dotfiles/etc/setup/brew.sh
  pip install $HOME/.dotfiles/requirements.txt
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
