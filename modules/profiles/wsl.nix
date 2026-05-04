{ pkgs, gitSigningKey, ... }:

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

  programs.git.signing = {
    format = "ssh";
    signer = "op-ssh-sign-wsl.exe";
    key = gitSigningKey;
    signByDefault = true;
  };

  home.packages =
    let
      xdg-open = pkgs.writeShellScriptBin "xdg-open" ''
        exec powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "Start \"$1\""
      '';
      pbcopy = pkgs.writeShellScriptBin "pbcopy" ''
        ${pkgs.wl-clipboard}/bin/wl-copy "$@"
      '';
      pbpaste = pkgs.writeShellScriptBin "pbpaste" ''
        ${pkgs.wl-clipboard}/bin/wl-paste --no-newline "$@" | ${pkgs.coreutils}/bin/tr -d '\r'
      '';
      op = pkgs.writeShellScriptBin "op" ''
        exec op.exe "$@"
      '';
    in
    [
      xdg-open
      pbcopy
      pbpaste
      op
      pkgs.bubblewrap
      pkgs.socat
    ];

  home.sessionVariables = {
    BROWSER = "xdg-open";
  };
}
