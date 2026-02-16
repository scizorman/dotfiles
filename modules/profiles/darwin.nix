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
    nerd-fonts.fira-code
  ];

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      initial-window = false;
      keybind = "global:alt+space=toggle_quick_terminal";
      quick-terminal-size = "100%, 100%";
      quick-terminal-position = "top";
      quick-terminal-animation-duration = 0;
      theme = "nightfox";
      font-family = "FiraCode Nerd Font Mono Ret";
      font-size = 12;
    };
    enableZshIntegration = true;
  };

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
