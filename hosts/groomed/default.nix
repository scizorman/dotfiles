{ pkgs, lib, ... }:

let
  username = "ca01216";
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];

  programs.zsh.enable = true;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  system.primaryUser = username;

  launchd.user.agents.colima = {
    serviceConfig = {
      Label = "com.github.abiosoft.colima";
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
      ];
      RunAtLoad = true;
      KeepAlive.SuccessfulExit = false;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeDWRbheAOzb7QoPZJdlH9ACbvFqBOHq9RzBTK3UmWe";
  };
  home-manager.users.${username} = {
    imports = [
      ../../modules/home
      ../../modules/profiles/darwin.nix
    ];

    xdg.configFile."1Password/ssh/agent.toml".text = ''
      [[ssh-keys]]
      vault = "CARTA HOLDINGS"
    '';
  };

  system.stateVersion = 6;
}
