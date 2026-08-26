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

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    # Public key of the Secure Enclave-backed signing key, created by the
    # bootstrap steps in README.md. Replace after running them.
    gitSigningKey = "sk-ecdsa-sha2-nistp256@openssh.com REPLACE_ME_WITH_ID_GIT_SIGN_PUB";
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
