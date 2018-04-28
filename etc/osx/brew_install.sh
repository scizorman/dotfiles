#!/bin/sh
# Install xcode
xcode-select --install

# Install Homebrew
if [ ! 'which brew' ]; then
  echo 'Install Homebrew ...'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo 'Homebrew is already installed.'
fi

# Install 'brew' packages
echo "Install 'Homebrew' packages ..."
brew install \
  git \
  neovim \
  python3 \
  tmux \
  zsh \
  zsh-completions 
