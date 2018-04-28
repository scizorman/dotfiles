#!/bin/sh
cd $HOME/.dotfiles > /dev/null 2>&1
msg=$(git pull)
er=$?
cd - > /dev/null 2>&1
if [[ $msg =~ "Already up-to-date" ]]; then
  echo "Dotfiles and binfiles are already up-to-date"
elif [[ $er = 0 ]]; then
  echo "Dotfiles and binfiles were updated"
fi
