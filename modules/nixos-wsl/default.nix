{ ... }:

{
  wsl.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "25.05";
}
