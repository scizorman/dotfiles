{
  config,
  pkgs,
  gitSigningKey,
  ...
}:

let
  onePasswordAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  home.packages = with pkgs; [
    _1password-cli
    colima
    docker-client
    docker-credential-helpers
    coreutils
    diffutils
    findutils
    gawk
    gnugrep
    gnused
    gnutar
  ];

  programs.git.signing = {
    format = "ssh";
    signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    key = gitSigningKey;
    signByDefault = true;
  };

  programs.ssh.matchBlocks."*".extraOptions = {
    IdentityAgent = ''"${onePasswordAgent}"'';
  };

  home.sessionVariables = {
    DOCKER_HOST = "unix://${config.xdg.configHome}/colima/default/docker.sock";
    SSH_AUTH_SOCK = onePasswordAgent;
  };
}
