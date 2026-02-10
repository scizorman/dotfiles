{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/nvim";
}
