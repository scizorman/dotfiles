{
  pkgs,
  config,
  windowsUsername,
  gitSigningKey,
  ...
}:

let
  wsl2-ssh-agent = pkgs.stdenv.mkDerivation {
    pname = "wsl2-ssh-agent";
    version = "0.9.7";
    src = pkgs.fetchurl {
      url = "https://github.com/mame/wsl2-ssh-agent/releases/download/v0.9.7/wsl2-ssh-agent";
      hash = "sha256-KBxk9geVmN4aRVKS1TPzriGDeYCj0wEgdLwUrWlTJdg=";
    };
    dontUnpack = true;
    installPhase = ''
      install -Dm755 $src $out/bin/wsl2-ssh-agent
    '';
  };

  sshAgentSocket = "${config.home.homeDirectory}/.ssh/wsl2-ssh-agent.sock";
in
{
  # WSL2 SSH Agent Bridge
  # Bridges Windows SSH agent (1Password) to Linux via socket
  systemd.user.services.wsl2-ssh-agent = {
    Unit = {
      Description = "WSL2 SSH Agent Bridge";
      ConditionUser = "!root";
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${wsl2-ssh-agent}/bin/wsl2-ssh-agent --foreground --socket=${sshAgentSocket}";
      Restart = "on-failure";
    };
  };

  # WSLg Wayland socket
  # WSL does not place the Wayland socket under $XDG_RUNTIME_DIR,
  # so we symlink it for wl-clipboard to work.
  systemd.user.services.wslg-wayland-socket = {
    Unit.Description = "Symlink WSLg Wayland socket";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/ln -sf /mnt/wslg/runtime-dir/wayland-0 %t/wayland-0";
    };
  };

  programs.ssh.matchBlocks."*".extraOptions = {
    IdentityAgent = sshAgentSocket;
  };

  programs.git.signing = {
    format = "ssh";
    signer = "/mnt/c/Users/${windowsUsername}/AppData/Local/Microsoft/WindowsApps/op-ssh-sign-wsl.exe";
    key = gitSigningKey;
    signByDefault = true;
  };

  home.packages =
    let
      pbcopy = pkgs.writeShellScriptBin "pbcopy" ''
        ${pkgs.wl-clipboard}/bin/wl-copy "$@"
      '';
      pbpaste = pkgs.writeShellScriptBin "pbpaste" ''
        ${pkgs.wl-clipboard}/bin/wl-paste --no-newline "$@" | ${pkgs.coreutils}/bin/tr -d '\r'
      '';
    in
    [
      pbcopy
      pbpaste
      pkgs.wslu
    ];

  home.sessionVariables = {
    BROWSER = "wslview";
    SSH_AUTH_SOCK = sshAgentSocket;
  };
}
