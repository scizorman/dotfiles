{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pnpm
    pipx
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."mise/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/mise/config/config.toml";
}
