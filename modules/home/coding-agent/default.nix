{ config, ... }:

let
  configDir = "${config.home.homeDirectory}/dotfiles/modules/home/coding-agent/config";

  mkSkillLinks =
    prefix:
    let
      skillsDir = builtins.readDir ./config/skills;
      skills = builtins.filter (name: skillsDir.${name} == "directory") (builtins.attrNames skillsDir);
    in
    builtins.listToAttrs (
      map (name: {
        name = "${prefix}/skills/${name}";
        value.source = config.lib.file.mkOutOfStoreSymlink "${configDir}/skills/${name}";
      }) skills
    );
in
{
  home.file = {
    ".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/claude/settings.json";

    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".codex/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/codex/config.toml";
    ".codex/rules/default.rules".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/codex/rules/default.rules";

  }
  // mkSkillLinks ".claude"
  // mkSkillLinks ".codex";

  xdg.configFile."copilot/config.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/copilot/config.json";
  xdg.configFile."copilot/copilot-instructions.md".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
}
