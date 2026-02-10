{ pkgs, ... }:

{
  imports = [
    ./programs/delta.nix
    ./programs/fzf.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/ssh.nix
    ./programs/television.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    bat
    dust
    eza
    fd
    ripgrep
  ];
  home.stateVersion = "26.05";
}
