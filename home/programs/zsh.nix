{ config, pkgs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.packages = with pkgs; [
    pure-prompt
    zsh-completions
  ];

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };

    history = {
      path = "${config.xdg.cacheHome}/zsh/zsh_history";
      size = 10000;
      save = 1000000;
      append = true;
      extended = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    localVariables = {
      WORDCHARS = "*?_-.[]~=&;!#$%^(){}<>";
    };

    sessionVariables = {
      ZCALC_HISTFILE = "${config.xdg.cacheHome}/zsh/zcalc_history";
    };

    setOptions = [
      "ALWAYS_LAST_PROMPT"
      "ALWAYS_TO_END"
      "AUTO_LIST"
      "AUTO_MENU"
      "AUTO_PARAM_KEYS"
      "AUTO_PARAM_SLASH"
      "AUTO_REMOVE_SLASH"
      "COMPLETE_IN_WORD"
      "LIST_TYPES"
      "BRACE_CCL"
      "EQUALS"
      "EXTENDED_GLOB"
      "GLOB_DOTS"
      "MAGIC_EQUAL_SUBST"
      "MARK_DIRS"
      "BANG_HIST"
      "HIST_NO_FUNCTIONS"
      "HIST_NO_STORE"
      "HIST_REDUCE_BLANKS"
      "HIST_SAVE_NO_DUPS"
      "HIST_VERIFY"
      "INC_APPEND_HISTORY"
      "CORRECT"
      "IGNORE_EOF"
      "INTERACTIVE_COMMENTS"
      "PATH_DIRS"
      "PRINT_EIGHT_BIT"
      "RM_STAR_WAIT"
      "AUTO_RESUME"
      "LONG_LIST_JOBS"
      "NOTIFY"
      "MULTIOS"
      "NO_LIST_BEEP"
      "NO_CASE_GLOB"
      "NO_HIST_BEEP"
      "NO_CLOBBER"
      "NO_FLOW_CONTROL"
      "NO_BEEP"
    ];

    initContent = ''
      source "${dotfilesDir}/config/zsh/keymaps.zsh"
      source "${dotfilesDir}/config/zsh/completions.zsh"

      # Utilities
      autoload -Uz zcalc

      # Prompt
      autoload -U promptinit && promptinit && prompt pure

      # Fast syntax highlighting (must be sourced last)
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    '';
  };
}
