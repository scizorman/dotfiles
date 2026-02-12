{ pkgs, ... }:

{
  imports = [
    ./claude.nix
    ./codex.nix
    ./copilot.nix
    ./gemini.nix
    ./git.nix
    ./mise.nix
    ./neovim.nix
    ./shell
    ./ssh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    gnumake
    nkf
    jq
    yq
  ];
  home.stateVersion = "26.05";
}
