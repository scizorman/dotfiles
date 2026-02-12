{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./claude.nix
    ./codex.nix
    ./copilot.nix
    ./eza.nix
    ./fzf.nix
    ./gemini.nix
    ./gh.nix
    ./ghq.nix
    ./git.nix
    ./mise.nix
    ./neovim.nix
    ./ripgrep.nix
    ./ssh.nix
    ./television.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    gnumake
    nkf
    fd
    jq
    yq
  ];
  home.stateVersion = "26.05";
}
