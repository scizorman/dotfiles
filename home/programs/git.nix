{ config, user, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.git = {
    enable = true;
    userName = user.git.name;
    userEmail = user.git.email;
    extraConfig = {
      commit.gpgsign = true;
      core.sshCommand = user.git.sshCommand;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = user.git.signing.program;
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
      pull.rebase = true;
      push.autoSetupRemote = true;
      tag.gpgsign = true;
      user.signingKey = user.git.signing.key;
    };
  };

  xdg.configFile."git".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/git";
}
