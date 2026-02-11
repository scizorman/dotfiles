{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  xdg.configFile."copilot/config.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/copilot/config.json";
}
