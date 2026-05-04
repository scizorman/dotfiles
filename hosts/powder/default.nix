{ pkgs, ... }:

let
  username = "scizorman";
in
{
  imports = [ ../../modules/profiles/wsl.nix ];

  networking.hostName = "powder";

  wsl.defaultUser = username;

  boot.tmp.cleanOnBoot = true;

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
    ];
  };

  system.stateVersion = "25.11";
}
