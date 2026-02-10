{ user, ... }:

{
  home.sessionVariables = {
    SSH_AUTH_SOCK = user.ssh.identityAgent;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = user.ssh.identityAgent;
        };
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
      };
    };
  };
}
