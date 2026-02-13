{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    ghq
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    git = true;
  };

  programs.fd = {
    enable = true;
    hidden = true;
  };

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

  programs.ripgrep = {
    enable = true;
  };

  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
    };

    initContent = ''
      function ghq-cd() {
        local dir="$(ghq list -p | fzf)"
        [[ -n "''${dir}" ]] && cd "''${dir}"
      }
      alias gl='ghq-cd'
    '';
  };
}
