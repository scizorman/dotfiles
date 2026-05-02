{ ... }:

{
  programs.television = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      shell_integration = {
        channel_triggers = {
          "alias" = [
            "alias"
            "unalias"
          ];
          "env" = [
            "export"
            "unset"
          ];
          "dirs" = [
            "cd"
            "ls"
            "rmdir"
          ];
          "files" = [
            "bat"
            "cat"
            "chmod"
            "chown"
            "cp"
            "gzip"
            "gunzip"
            "head"
            "less"
            "ln"
            "mv"
            "nano"
            "rm"
            "tail"
            "tar"
            "touch"
            "unzip"
            "xz"
            "zip"
          ];
          "git-files" = [
            "git blame"
            "git diff"
          ];
          "git-diff" = [
            "git add"
            "git restore"
          ];
          "git-branch" = [
            "git checkout"
            "git switch"
            "git branch"
            "git merge"
            "git rebase"
            "git pull"
            "git push"
          ];
          "git-log" = [
            "git log"
            "git revert"
            "git show"
          ];
          "git-repos" = [ "nvim" ];
          "git-worktrees" = [ "git worktree" ];
          "docker-images" = [ "docker run" ];
        };
      };
    };
  };
}
