{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file = {
    ".codex/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/codex/config.toml";
  };
}
