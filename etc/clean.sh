#!/bin/sh
DOTFILES=$(ls -A $HOME/.dotfiles | grep -v 'Makefile\|README.md\|.gitignore\|bin\|etc\|.git\|.DS_Store')
BINFILES=$(ls -A $HOME/.dotfiles/bin | grep -v '.DS_Store|')

while true; do
  read -n 1 -p "    Remove dotfiles and binfiles [y/n]: " answer
  echo
  case $answer in
    "y" )
      for dotfile in ${DOTFILES[@]}; do
        unlink $HOME/$dotfile
        [[ $? = 0 ]] && echo "        - unlinked: $dotfile"
      done

      [[ -e $XDG_CONFIG_HOME/nvim/init.vim ]] && unlink $XDG_CONFIG_HOME/nvim/init.vim

      for binfile in ${BINFILES[@]}; do
        unlink /usr/local/bin/$binfile
        [[ $? = 0 ]] && echo "        - unlinked: $binfile"
      done
      
      rm -rf $HOME/.dotfiles
      echo ".dotfiles were removed."
      echo "More information about .dotfiles: https://github.com/Scizor-master/.dotfiles"
    ;;
    "n" ) exit 0 ;;
    * ) echo "Please press y(yes) or n(no)";;
  esac
done
