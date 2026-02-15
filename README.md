# Dotfiles

## Overview

Personal dotfiles managed with Nix flakes for reproducible development environments across NixOS and macOS.

## Setup

### NixOS (WSL)

Update the channel and clone the repository:

```bash
sudo nix-channel --update
nix-shell -p git
git clone <repo-url> ~/dotfiles
```

Apply the configuration with `boot` and restart WSL:

```bash
sudo nixos-rebuild boot --flake ~/dotfiles#<hostname>
```

From PowerShell:

```powershell
wsl -t NixOS
wsl -d NixOS --user root exit
wsl -t NixOS
```

After restart, clone the repository again as the new user and apply the configuration:

```bash
nix-shell -p git
git clone <repo-url> ~/dotfiles
make switch
```

### macOS

Install Nix:

```bash
curl -L https://nixos.org/nix/install | sh
```

Clone the repository and apply the initial configuration:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#<hostname>
```

If the activation fails due to unexpected files in `/etc`, rename them and try again:

```bash
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
```

After the initial setup, use `darwin-rebuild` directly for subsequent configuration changes:

```bash
sudo darwin-rebuild switch --flake ~/dotfiles#<hostname>
```

## Usage

Apply configuration changes:

```bash
make switch
```

View available targets:

```bash
make
```
