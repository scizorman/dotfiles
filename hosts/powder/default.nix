{ pkgs, ... }:

let
  username = "scizorman";
  homeDir = "/home/${username}";
  windowsUsername = "tueda";
in
{
  wsl.defaultUser = username;
  networking.hostName = "powder";

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "docker" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    user = {
      clipboard = {
        copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        paste = "${pkgs.wl-clipboard}/bin/wl-paste --no-newline | ${pkgs.coreutils}/bin/tr -d '\\r'";
      };
      ssh = {
        identityAgent = "${homeDir}/.1password/agent.sock";
      };
      git = {
        name = "Tetsutaro Ueda";
        email = "tueda1207@gmail.com";
        sshCommand = "ssh.exe";
        signing = {
          program = "/mnt/c/Users/${windowsUsername}/AppData/Local/Microsoft/WindowsApps/op-ssh-sign.exe";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENZsRA5UEd0JQLH8AdGnYlqpj2mG9oCUluMXsjLiZ6T";
        };
      };
    };
  };
  home-manager.users.${username} = {
    imports = [ ../../modules/home-manager ];
  };
}
