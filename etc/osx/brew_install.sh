#!/bin/sh
cat << START

************************************************
START TO INSTALL HOMEBREW AND FORMULAS!!
************************************************

START


#Install xcode
printf "Installing \033[34mxcode-select\033[m...\n"
if xcode-select --install > /dev/null 2>&1; then
  xcode-select --install
else
  echo "  Already 'xcode-select' installed."
fi


# Install Homebrew
printf "\nInstalling \033[34mHomebrew\033[m...\n"
if which brew > /dev/null 2>&1; then
  echo "  Already Homebrew installed."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "\nRun 'brew doctor'"
brew doctor

echo "\nRun 'brew update'"
brew update

echo "\nRun 'brew upgrade'"
brew upgrade

# Install formulas
formulas=(
  git
  zsh
  # zplug
  tmux
  # "vim --with-lua"
  neovim
  python3
)

echo "\nInstalling formulas..."
for formula in "${formulas[@]}"; do
  brew install $formula || brew upgrade $formula
done

echo ''
echo "Run 'brew cleanup'"
brew cleanup


cat << END

************************************************
COMPLETE TO INSTALL HOMEBREW AND FORMULAS!!
************************************************

END
