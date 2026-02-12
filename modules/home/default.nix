{ pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./git.nix
    ./shell
    ./neovim
    ./mise
    ./coding-agent
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    gnumake
    jq
    nkf
    yq
  ];

  home.stateVersion = "25.11";
}
