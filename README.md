# Scizor-master dotfiles

## Overview
This is dotfiles for **Zsh**, **Tmux**, and **Vim/Neovim**. 


## Installation
The easist way to install this dotfiles is to open up a terminal, type the installation command below: Run the following command to setup a new machine:

<table>
  <thead>
    <tr>
      <th></th>
      <th><a name="oneliner">Installation command</a></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>cURL</strong></td>
      <td>sh -c "$(curl -fsSL <a href="https://raw.githubusercontent.com/Scizor-master/dotfiles/master/etc/install.sh">https://raw.githubusercontent.com/Scizor-master/dotfiles/master/etc/install.sh</a>)"</td>
    </tr>
    <tr>
      <td><strong>Wget</strong></td>
      <td>sh -c "$(wget -qO - <a href="https://raw.githubusercontent.com/Scizor-master/dotfiles/master/etc/install.sh">https://raw.githubusercontent.com/Scizor-master/dotfiles/master/etc/install.sh</a>)"</td>
    </tr>
  </tbody>
</table>

- It is almost the same as the command below except for executing through a Web site directly.

  ```console
  $ make install
  ```

- General download method using the git command:

  ```console
  $ git clone https://github.com/Scizor-master/dotfiles.git ~/.dotfiles
  $ cd ~/.dotfiles && make install
  ```

  Incidentally, `make install` will perform the following tasks.

  - `make update`: Updating dotfiles repository
  - `make deploy`: Deploying dot files
  - `make init`: Initializing some settings

**What's inside?**
1. Download this repository
1. Deploy (i.e. *copy* or *create symlink*) dot files to your home directory; `make deploy`
1. Run all programs for setup in `./etc/init` directory; `make init` (**Optional**: when running the [installation command](#oneliner) specify `-s init` as an argument)

When the [installation command](#onliner) format is not curl -L URL | sh but `sh -c "$(curl -L URL)"`, shell will be restart automatically. If this is not the case, it is necessary to restart your shell manually.


## Update
To update later on, just run this command.

  ```console
  $ make update
  ```

## Setup

### Initialize
All configuration files for setup is stored within the `etc/init` directory. By running the command below, you can interactively setup all preferences.

  ```console
  $make init
  ```

## Uninstall
To remove this dotfiles, run the command below.

  ```console
  $ make clean
  ```
