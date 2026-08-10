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
  sshKeygenSecureEnclave = pkgs.writeShellApplication {
    name = "ssh-keygen-secure-enclave";
    text = ''
      export SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib
      exec /usr/bin/ssh-keygen "$@"
    '';
  };

  # One-shot bootstrap; run manually once after switch.
  # Not an activation script: sc_auth touches Secure Enclave / keychain and
  # can silently fail outside the user's GUI security session, and failures
  # are easier to recover interactively (sc_auth delete-ctk-identity -l git-sign).
  bootstrapGitSigningKey = pkgs.writeShellApplication {
    name = "bootstrap-git-signing-key";
    text = ''
      key="$HOME/.ssh/id_git_sign"
      if [ -f "$key" ]; then
        echo "Already bootstrapped: $key"
        exit 0
      fi
      if ! sc_auth list-ctk-identities 2>/dev/null | grep -q 'git-sign'; then
        sc_auth create-ctk-identity -l git-sign -k p-256-ne -t none
      fi
      tmp="$(mktemp -d)"
      trap 'rm -rf "$tmp"' EXIT
      (
        cd "$tmp" || exit 1
        # -K writes ALL resident keys into CWD, hence the temp dir.
        SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib /usr/bin/ssh-keygen -K -N ""
      )
      mkdir -p "$HOME/.ssh"
      mv "$tmp"/id_ecdsa_sk_rk "$key"
      mv "$tmp"/id_ecdsa_sk_rk.pub "$key.pub"
      chmod 600 "$key"
      echo "Register this key on GitHub as a signing key:"
      cat "$key.pub"
    '';
  };
in
{
  home.packages =
    (with pkgs; [
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
    ])
    ++ [ bootstrapGitSigningKey ];

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
