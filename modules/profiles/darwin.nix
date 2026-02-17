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

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      font-size = 12;
      theme = "nightfox";
      background-opacity = 0.75;
      working-directory = "home";
      keybind = "global:alt+space=toggle_quick_terminal";
      window-inherit-working-directory = false;
      initial-window = false;
      quick-terminal-position = "top";
      quick-terminal-size = "100%, 100%";
      quick-terminal-animation-duration = 0;
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

  launchd.agents.colima = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
      ];
      KeepAlive = {
        SuccessfulExit = true;
      };
      RunAtLoad = true;
      StandardOutPath = "/tmp/colima.stdout.log";
      StandardErrorPath = "/tmp/colima.stderr.log";
      EnvironmentVariables = {
        PATH = "${pkgs.docker-client}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
        XDG_CONFIG_HOME = config.xdg.configHome;
      };
    };
  };

  launchd.agents.ghostty = {
    enable = true;
    config = {
      ProgramArguments = [ "${config.programs.ghostty.package}/bin/ghostty" ];
      RunAtLoad = true;
    };
  };

  home.sessionVariables = {
    DOCKER_HOST = "unix://${config.xdg.configHome}/colima/default/docker.sock";
    SSH_AUTH_SOCK = onePasswordAgent;
  };
}
