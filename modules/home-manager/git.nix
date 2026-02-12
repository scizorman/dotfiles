{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "UEDA Tetsutaro";
      user.email = "tueda1207@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge.conflictStyle = "diff3";
    };
  };

  xdg.configFile."git/ignore".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/git/ignore";
}
