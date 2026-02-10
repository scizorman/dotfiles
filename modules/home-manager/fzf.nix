{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden";
    defaultOptions = [
      "--extended"
      "--ansi"
      "--multi"
      "--border"
      "--reverse"
    ];
  };
}
