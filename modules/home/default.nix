{ pkgs, ... }:

{
  imports = [
    ./coding-agent
    ./git.nix
    ./mise
    ./neovim
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
