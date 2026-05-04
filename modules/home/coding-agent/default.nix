{ config, lib, ... }:

let
  configDir = "${config.home.homeDirectory}/dotfiles/modules/home/coding-agent/config";
  codexConfigTemplate = ./config/codex/config.toml;

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
({
  home.file = {
    ".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".claude/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/claude/settings.json";

    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
    ".codex/rules/default.rules".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/codex/rules/default.rules";

    ".copilot/config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/copilot/config.json";
    ".copilot/copilot-instructions.md".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/AGENTS.md";
  }
  // mkSkillLinks ".claude"
  // mkSkillLinks ".codex";

  home.activation.codexConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${lib.escapeShellArg "${config.home.homeDirectory}/.codex"}
    # Replace the previous symlink so Codex can persist runtime state in a plain file.
    run rm -f ${lib.escapeShellArg "${config.home.homeDirectory}/.codex/config.toml"}
    run install -m 644 \
      ${lib.escapeShellArg "${toString codexConfigTemplate}"} \
      ${lib.escapeShellArg "${config.home.homeDirectory}/.codex/config.toml"}
  '';
})
