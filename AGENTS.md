# dotfiles

Nix flake-based dotfiles for NixOS WSL and darwin hosts.

## Architecture Rules

`flake.nix` enumerates hosts and shared outputs only.
Do not move host assembly logic into it.

`hosts/{hostname}/default.nix` is the only host entry point.
Keep NixOS and darwin system configuration in host files until multiple machines share the same OS-level configuration.

`modules/home/` contains environment-independent Home Manager configuration.
It defines what tools and base configuration are installed.
Do not put OS-specific or runtime-specific behavior here.

`modules/profiles/` contains runtime-specific integrations, environment values, and supporting packages.
It defines what common tools connect to in a given environment.
Use profiles for WSL integration such as clipboard, credential helpers, agents, and browser bridges.

Keep OS concerns and runtime concerns separate.
NixOS, Ubuntu, and darwin differ on the OS axis.
WSL and native environments differ on the runtime axis.

## File Placement

Use `modules/home/{tool}.nix` for stable tool configuration that can be expressed declaratively through Home Manager or Nix.

Use `modules/home/{tool}/default.nix` with `modules/home/{tool}/config/` for tools whose configuration is managed through `mkOutOfStoreSymlink`.
This applies to complex, frequently edited, or toolchain-integrated config such as Neovim, mise, and coding agent configuration.

Keep `default.nix` files as import or module assembly points unless the existing local pattern requires settings there.
Do not introduce `home.nix` splits, provider abstractions, or shared OS modules unless duplication has created real maintenance cost.

## Commands

Use the Makefile for repository checks and host operations.
Run `make` with no arguments to inspect available targets before using an unfamiliar target.

Run `make fmt` for formatting.
Run `make check` for flake checks.

Use environment-specific host targets only when validating host-level changes.
On NixOS hosts, `make build`, `make diff`, `make test`, and `make switch` are provided when `nixos-rebuild` is available.
On darwin hosts, `make build`, `make diff`, and `make switch` are provided when `darwin-rebuild` is available.
