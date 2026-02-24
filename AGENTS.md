# dotfiles

A repository managing dotfiles across multiple environments using Nix flake.

## Architecture

### Directory Structure

```
flake.nix
hosts/
  {hostname}/default.nix    # system config + module assembly
modules/
  home/
    default.nix              # imports only
    {tool}.nix               # single-tool config (Nix-generated)
    {tool}/                  # tool with config/ (mkOutOfStoreSymlink)
      default.nix
      config/
  profiles/
    {runtime}.nix            # environment-specific additions
```

### Separation of Parts and Assembly

`modules/` holds reusable parts; `hosts/` is where parts are assembled. The structure mirrors NixOS's own `nixos/modules/`.

`flake.nix` only enumerates hosts and contains no logic. Each host's `default.nix` is the sole entry point — no splitting into `home.nix` or similar.

### Two Axes of Variation

Environment differences arise along two independent axes.

- **OS axis** (NixOS / Ubuntu / darwin) — differences in system management
- **runtime axis** (WSL / native) — presence or absence of host OS integration layer

WSL-specific settings (clipboard, credential helper, IdentityAgent, BROWSER, etc.) are common regardless of OS. These two axes are orthogonal and must not be mixed.

### modules/home/ — User Environment Common to All Environments

Importing `default.nix` brings in all common settings independent of OS and runtime. No environment-specific files belong here.

When depending on external commands, assume an environment-agnostic interface (e.g., `pbcopy` / `pbpaste`). This module has no knowledge of what provides the actual implementation.

### modules/profiles/ — Environment-Specific Additions

Modeled after NixOS's `nixos/modules/profiles/` (e.g., `qemu-guest.nix`), this directory holds configuration presets for specific runtime environments. Hosts explicitly choose which profiles to import.

A profile's responsibilities are three: provide the concrete implementation of interfaces assumed by `home/`, inject environment-specific values into existing settings, and add environment-specific packages. All injection rides on Home Manager's module system merging.

### Boundary Between home/ and profiles/

`home/` is responsible for *what* gets installed; `profiles/` is responsible for *what it connects to*. Tool installation and base configuration go in `home/`; connections to secret stores and agents go in `profiles/`.

### Handling System-Level Configuration

NixOS and darwin system configuration is written directly in the host. Extracting shared modules is only considered once multiple machines share the same OS. `modules/nixos/` or `modules/darwin/` is added at that point.

## Design Decisions

### Follow Nix Naming Conventions

`modules/` and `profiles/` are derived from NixOS's own directory structure. Avoid names tied to implementation details (`homeModules`, `nixosModules`) or invented concepts (`platform`, `system`, `common`).

### File Splitting Criteria

A single tool's config uses the tool name (`git.nix`, `ssh.nix`); a bundle of related tools uses the concern name (`shell/`, `coding-agent/`). `default.nix` contains only imports — no settings mixed in.

Tools with config files managed via `mkOutOfStoreSymlink` become directories (`neovim/`, `mise/`, `coding-agent/`). Tools that are purely Nix-generated remain files (`git.nix`, `ssh.nix`). This keeps the Nix config and the actual config files co-located. Since Nix's `import` reads `default.nix` when given a directory, the `imports` list stays uniform.

### Two File Management Strategies

**Nix-generated** — Stable configurations expressible declaratively via Home Manager's `programs.*`. Managed as `.nix` files and applied with `home-manager switch`.

**mkOutOfStoreSymlink** — Configurations with complex structure, frequent manual edits, or integration with toolchains outside Nix (Neovim Lua config, mise config, coding agent config, etc.). The actual files live in `config/` inside the tool directory and are symlinked directly to the repository. Edits take effect immediately.

### Avoid Premature Abstraction

There are at most 3–5 host variants. DI-style provider patterns and module option abstractions are introduced only when duplication or change costs become genuinely painful. Small duplication across profiles is acceptable.

## Commands

Run via Makefile. Run `make` with no arguments to see available targets.
