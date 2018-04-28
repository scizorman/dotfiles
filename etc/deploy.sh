#!/bin/sh
DOTFILES=$(ls -A $HOME/.dotfiles | grep -v 'Makefile\|README.md\|.gitignore\|bin\|etc\|.git\|.DS_Store')
BINFILES=$(ls -A $HOME/.dotfiles/bin | grep -v '.DS_Store|')

echo "    Start to link dotfiles ..."
i=0
for dotfile in ${DOTFILES[@]}; do
  if [ ! -e $HOME/$dotfile ]; then
    (( i++ ))
    ln -s $HOME/.dotfiles/$dotfile $HOME/$dotfile
    [[ $? = 0 ]] && echo "        + linked: $dotfile"
  fi
done
[ $i = 0 ] && echo "        All dotfiles are already linked."

# init.vim (Neovim)
[ ! -e $XDG_CONFIG_HOME ] && echo 'XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.zshrc

if [ ! -e $XDG_CONFIG_HOME/nvim/init.vim ]; then
  [ ! -e $XDG_CONFIG_HOME/nvim ] && mkdir -p $XDG_CONFIG_HOME/nvim
  ln -s $HOME/.dotfiles/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
  echo "            + linked: .vimrc ==> $XDG_CONFIG_HOME/nvim/init.vim"
else
  echo "        'init.vim' is already linked.\n"
fi

# Bin files
echo "    Start to link binfiles ..."
i=0
for binfile in ${BINFILES[@]}; do
  if [ ! -e /usr/local/bin/$binfile ]; then
    (( i++ ))
    ln -s $HOME/.dotfiles/bin/$binfile /usr/local/bin/$binfile
    [[ $? = 0 ]] && echo "            + linked: $binfile"install
  fi
done
[ $i = 0 ] && echo "        All binfiles are already linked."
