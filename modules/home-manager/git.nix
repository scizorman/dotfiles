{ config, user, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      commit.gpgsign = true;
      core.sshCommand = user.git.sshCommand;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = user.git.signing.program;
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
      pull.rebase = true;
      push.autoSetupRemote = true;
      tag.gpgsign = true;
      user = {
        name = user.git.name;
        email = user.git.email;
        signingKey = user.git.signing.key;
      };
    };
  };

  xdg.configFile."git/ignore".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/git/ignore";
}
