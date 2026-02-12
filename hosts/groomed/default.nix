{ pkgs, ... }:

let
  username = "ca01216";
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeDWRbheAOzb7QoPZJdlH9ACbvFqBOHq9RzBTK3UmWe";
  };
  home-manager.users.${username} = {
    imports = [
      ../../modules/home-manager
      ../../modules/profiles/darwin.nix
    ];
  };

  system.stateVersion = 6;
}
