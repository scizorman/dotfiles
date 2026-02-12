{ pkgs, ... }:

let
  username = "ca01216";
  homeDir = "/Users/${username}";
in
{
  users.users.${username} = {
    home = homeDir;
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    user = {
      clipboard = {
        copy = "pbcopy";
        paste = "pbpaste";
      };
      ssh = {
        identityAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      };
      git = {
        name = "Tetsutaro Ueda";
        email = "tueda1207@gmail.com";
        sshCommand = "ssh";
        signing = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeDWRbheAOzb7QoPZJdlH9ACbvFqBOHq9RzBTK3UmWe";
        };
      };
    };
  };
  home-manager.users.${username} = {
    imports = [ ../../modules/home-manager ];
  };
}
