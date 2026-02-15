{ config, pkgs, ... }:

let
  username = "scizorman";
in
{
  networking.hostName = "powder";

  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.interop.register = true;

  # Ensure binfmt registration is re-applied after nixos-rebuild
  systemd.services.systemd-binfmt.restartTriggers = [
    config.environment.etc."binfmt.d/nixos.conf".source
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  virtualisation.docker.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
    linger = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENZsRA5UEd0JQLH8AdGnYlqpj2mG9oCUluMXsjLiZ6T";
  };
  home-manager.users.${username} = {
    imports = [
      ../../modules/home
      ../../modules/profiles/wsl.nix
    ];
  };

  system.stateVersion = "25.11";
}
