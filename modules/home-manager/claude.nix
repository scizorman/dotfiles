{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file = {
    ".claude/CLAUDE.md".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/claude/CLAUDE.md";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/claude/settings.json";
    ".claude/commands".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/claude/commands";
    ".claude/skills".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/claude/skills";
  };
}
