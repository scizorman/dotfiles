{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file = {
    ".gemini/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/gemini/settings.json";
  };
}
