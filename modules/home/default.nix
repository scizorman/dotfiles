{ pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./git.nix
    ./shell
    ./neovim
    ./mise
    ./cloud.nix
    ./coding-agent
  ];

  xdg.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gnumake
    grpcurl
    jq
    mermaid-cli
    nkf
    noto-fonts-cjk-sans
    openssl
    poppler-utils
    unzip
    yq
  ];

  home.stateVersion = "25.11";
}
