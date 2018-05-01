#!/bin/sh
OSTYPE="$(uname -s)"
DOT_DIR="$HOME/.dotfiles"

if [[ $OSTYPE =~ (D|d)arwin* ]]; then
  SETUP_OSX_DIR=$DOT_DIR/osx

  ./$SETUP_OSX_DIR/brew_install.sh

  pip install -r $SETUP_OSX_DIR/neovim_2_requirements.txt
  pip3 install -r $SETUP_OSX_DIR/neovim_3_requirements.txt

else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
