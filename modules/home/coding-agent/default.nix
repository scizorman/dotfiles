{ config, ... }:

let
  configDir = "${config.home.homeDirectory}/dotfiles/modules/home/coding-agent/config";

  mkSkillLinks =
    prefix:
    let
      skills = [
        "git-operator"
        "github-issue-creator"
        "github-pr-creator"
        "github-sub-issue-creator"
      ];
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
    ".claude/commands/self-critique.md".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/claude/commands/self-critique.md";

    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".codex/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/codex/config.toml";

  }
  // mkSkillLinks ".claude"
  // mkSkillLinks ".codex";

  xdg.configFile."copilot/config.json".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/copilot/config.json";
  xdg.configFile."copilot/copilot-instructions.md".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
}
