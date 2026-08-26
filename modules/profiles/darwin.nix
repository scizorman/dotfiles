{
  config,
  pkgs,
  lib,
  ...
}:

let
  onePasswordAgent = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";

  # Apple's ssh-keygen is required: it can load /usr/lib/ssh-keychain.dylib
  # as an SK provider, which nixpkgs openssh is not verified to do.
  # "-Y sign" itself takes no provider flag (only "-K"/"-w", used when
  # creating a key, do), and SSH_SK_PROVIDER's default is the built-in USB
  # HID transport rather than the Secure Enclave. Pin it in a wrapper
  # instead of depending on the caller's shell environment.
  sshKeygenSecureEnclave =
    pkgs.runCommand "ssh-keygen-secure-enclave"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
        meta.mainProgram = "ssh-keygen-secure-enclave";
      }
      ''
        makeWrapper /usr/bin/ssh-keygen $out/bin/ssh-keygen-secure-enclave \
          --set SSH_SK_PROVIDER /usr/lib/ssh-keychain.dylib
      '';
in
{
  home.packages = with pkgs; [
    _1password-cli
    docker-client
    docker-credential-helpers
    coreutils
    diffutils
    findutils
    gawk
    gnugrep
    gnused
    gnutar
    hackgen-nf-font
  ];

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      font-family = "HackGen Console NF";
      font-size = 12;
      theme = "nightfox";
      background-opacity = 0.90;
      working-directory = "home";
      keybind = "global:alt+space=toggle_quick_terminal";
      window-inherit-working-directory = false;
      window-save-state = "never";
      initial-window = false;
      quick-terminal-position = "top";
      quick-terminal-size = "100%, 100%";
      quick-terminal-animation-duration = 0;
    };
    enableZshIntegration = true;
  };

  programs.git.signing = {
    format = "ssh";
    signer = lib.getExe sshKeygenSecureEnclave;
    key = "${config.home.homeDirectory}/.ssh/id_git_sign";
    signByDefault = true;
  };

  programs.ssh.matchBlocks."*".extraOptions = {
    # The path contains a space ("Group Containers"), so it must be quoted in
    # ssh_config. Home Manager writes extraOptions values verbatim, so we embed
    # the surrounding double-quotes in the Nix string itself.
    IdentityAgent = "\"${onePasswordAgent}\"";
  };

  services.colima = {
    enable = true;
    colimaHomeDir = "${config.xdg.configHome}/colima";
    profiles.default = {
      isActive = true;
      isService = true;
      setDockerHost = true;
      settings = {
        runtime = "docker";
        cpu = 4;
        memory = 12;
      };
    };
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = onePasswordAgent;
  };
}
