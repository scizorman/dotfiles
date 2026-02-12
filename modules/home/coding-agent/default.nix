{ config, ... }:

let
  configDir = "${config.home.homeDirectory}/dotfiles/modules/home/coding-agent/config";
in
{
  home.file = {
    ".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/claude/settings.json";
    ".claude/commands".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/claude/commands";
    ".claude/skills".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/skills";

    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".codex/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/codex/config.toml";
    ".codex/skills".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/skills";

    ".gemini/GEMINI.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".gemini/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/gemini/settings.json";
  };

  xdg.configFile."copilot/config.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/copilot/config.json";
  xdg.configFile."copilot/copilot-instructions.md".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
}
