{ pkgs, ... }:

{
  imports = [
    ./programs/bat.nix
    ./programs/delta.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/ripgrep.nix
    ./programs/ssh.nix
    ./programs/television.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    fd
  ];
  home.stateVersion = "26.05";
}
