#!/bin/sh
if [ ! -e $HOME/.dotfiles ]; then
  if type git >/dev/null 2>&1; then
    echo "Downloading .dotfiles with git ..."
    git clone https://github.com/Scizor-master/.dotfiles $HOME/
  else
    tarball="https://github.com/Scizor-master/.dotfiles/archive/master.tar.gz"
    if type curl >/dev/null 2>&1; then
      echo "Downloading .dotfiles with curl ..."
      curl -L "$tarball" | tar zx
    elif type wget >/dev/null 2>&1; then
      echo "Downloading .dotfiles with wget ..."
      wget -O - "$tarball" | tar zx
    fi
    mv -f .dotfiles-master $HOME/.dotfiles
  fi
fi

if [ "$(uname)" == 'Darwin' ]; then
  echo "    Install 'brew' packages ...\n"
  $HOME/.dotfiles/etc/osx/brew_install.sh

  echo "\n    Install python3 packages ...\n"
  pip3 install -r $HOME/.dotfiles/etc/neovim_requirements.txt

else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
