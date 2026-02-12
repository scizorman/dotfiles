{ config, pkgs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."mise/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/mise/config.toml";
}
