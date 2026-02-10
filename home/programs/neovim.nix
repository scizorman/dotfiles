{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/nvim";
}
