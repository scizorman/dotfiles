{ user, ... }:

{
  home.sessionVariables = {
    SSH_AUTH_SOCK = user.ssh.identityAgent;
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "${user.ssh.identityAgent}"
    '';
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
      };
    };
  };
}
