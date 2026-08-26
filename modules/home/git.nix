{ config, gitSigningKey, ... }:

let
  allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      # Claude Code
      "**/.claude/settings.local.json"
      "**/CLAUDE.local.md"

      # direnv
      ".direnv"
      ".envrc"

      # Linux
      "*~"
      ".fuse_hidden*"
      ".directory"
      ".Trash-*"
      ".nfs*"

      # macOS
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon\r\r"
      "._*"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      "*.icloud"
    ];
    settings = {
      user.name = "UEDA Tetsutaro";
      user.email = "tueda1207@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      merge.conflictStyle = "diff3";
      url."git@github.com:".insteadOf = "https://github.com/";
      gpg.ssh.allowedSignersFile = allowedSignersFile;
    };
  };

  # Lets `git log --show-signature` verify this host's own commits against
  # its signing key. Only the public key is stored here, so it is safe to
  # keep in the world-readable Nix store.
  xdg.configFile."git/allowed_signers".text =
    "${config.programs.git.settings.user.email} ${gitSigningKey}\n";

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.zsh.shellAliases = {
    diff = "delta";
  };
}
