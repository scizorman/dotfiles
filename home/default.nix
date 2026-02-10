{ pkgs, ... }:

{
  imports = [
    ./programs/delta.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/ssh.nix
    ./programs/zsh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    bat
    eza
    fzf
  ];
  home.stateVersion = "26.05";
}
