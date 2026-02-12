{
  pkgs,
  windowsUsername,
  gitSigningKey,
  ...
}:

{
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

  programs.git = {
    signing = {
      format = "ssh";
      signer = "/mnt/c/Users/${windowsUsername}/AppData/Local/Microsoft/WindowsApps/op-ssh-sign.exe";
      key = gitSigningKey;
      signByDefault = true;
    };
    settings = {
      core.sshCommand = "ssh.exe";
    };
  };

  # lazy.nvim hardcodes GIT_SSH_COMMAND="ssh -oBatchMode=yes" as a default,
  # which overrides core.sshCommand and uses Linux ssh instead of ssh.exe.
  # Setting this via the neovim wrapper ensures 1Password SSH agent is used.
  programs.neovim.extraWrapperArgs = [
    "--set"
    "GIT_SSH_COMMAND"
    "ssh.exe"
  ];

  home.sessionVariables = {
    BROWSER = "wslview";
  };
}
