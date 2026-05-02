{ ... }:

{
  programs.television = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      shell_integration = {
        channel_triggers = {
          # environment
          "env" = [
            "export"
            "unset"
          ];
          # filesystem
          "dirs" = [
            "cd"
            "ls"
            "rmdir"
            "z"
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
            "vim"
            "xz"
            "zip"
          ];
          # git
          "git-files" = [
            "git blame"
            "git show"
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
          "git-log" = [ "git log" ];
          "git-repos" = [
            "code"
            "git clone"
            "hx"
            "nvim"
          ];
          "git-worktrees" = [ "git worktree" ];
          # containers
          "docker-images" = [ "docker run" ];
        };
      };
    };

    channels = {
      git-files = {
        metadata = {
          name = "git-files";
          description = "A channel to list the files currently tracked in the Git repository";
          requirements = [
            "git"
            "bat"
          ];
        };
        source.command = "git ls-files $(git rev-parse --show-toplevel)";
        preview = {
          command = "bat -n --color=always '{}'";
          env.BAT_THEME = "ansi";
        };
        keybindings."f12" = "actions:edit";
        actions.edit = {
          description = "Opens the selected entries with the default editor (falls back to vim)";
          command = "\${EDITOR:-vim} '{}'";
          shell = "bash";
          mode = "execute";
        };
      };
      git-worktrees = {
        metadata = {
          name = "git-worktrees";
          description = "List and switch between git worktrees";
          requirements = [ "git" ];
        };
        source.command = "git worktree list --porcelain | grep '^worktree' | cut -d' ' -f2-";
        preview.command = "cd '{}' && git log --oneline -10 --color=always && echo && git status --short";
        keybindings = {
          enter = "actions:cd";
          "ctrl-d" = "actions:remove";
        };
        actions = {
          cd = {
            description = "Change to the selected worktree";
            command = "cd '{}' && $SHELL";
            mode = "execute";
          };
          remove = {
            description = "Remove the selected worktree";
            command = "git worktree remove '{}'";
            mode = "execute";
          };
        };
      };
      zsh-history = {
        metadata = {
          name = "zsh-history";
          description = "A channel to select from your zsh history";
          requirements = [ "zsh" ];
        };
        source = {
          command = "sed '1!G;h;$!d' \${HISTFILE:-\${HOME}/.zsh_history}";
          display = "{split:;:1..}";
          output = "{split:;:1..}";
          no_sort = true;
          frecency = false;
        };
        actions.execute = {
          description = "Execute the selected command";
          command = "zsh -c '{split:;:1..}'";
          mode = "execute";
        };
      };
    };
  };
}
