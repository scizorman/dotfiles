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

#### Git commit signing key

Commits are signed with a Secure Enclave-backed key (non-exportable), so this
key must be created once per Mac before the first commit. `signByDefault` is
enabled, so every commit fails until this is done.

```bash
sc_auth create-ctk-identity -l git-sign -k p-256-ne -t none

# -K writes every resident key into the current directory, hence the temp dir.
cd "$(mktemp -d)"
SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib ssh-keygen -K -N ""
mv id_ecdsa_sk_rk ~/.ssh/id_git_sign
mv id_ecdsa_sk_rk.pub ~/.ssh/id_git_sign.pub
chmod 600 ~/.ssh/id_git_sign
```

Register the contents of `~/.ssh/id_git_sign.pub` as a signing key on GitHub.

To start over, find the identity's hash and delete it:

```bash
sc_auth list-ctk-identities
sc_auth delete-ctk-identity -h <hash>
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
