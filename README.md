# Dotfiles

## Overview

This is dotfiles for **Zsh**, **Tmux**, and **Neovim**.

## Installation

Open a new terminal and enter:

```console
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${HOME}/.local/bin"
$ "${HOME}/.local/bin/chezmoi init https://github.com/scizorman/dotfiles.git"
$ chezmoi apply -v
```
