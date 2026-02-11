{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./clipboard.nix
    ./delta.nix
    ./eza.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./mise.nix
    ./neovim.nix
    ./ripgrep.nix
    ./ssh.nix
    ./television.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    fd
    gnumake
    nkf
  ];
  home.stateVersion = "26.05";
}
