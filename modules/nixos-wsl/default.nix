{ config, pkgs, ... }:

{
  wsl.enable = true;
  wsl.interop.register = true;

  # Ensure binfmt registration is re-applied after nixos-rebuild
  systemd.services.systemd-binfmt.restartTriggers = [
    config.environment.etc."binfmt.d/nixos.conf".source
  ];

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  # WSLg Wayland socket
  # NixOS-WSL only bind-mounts the X11 socket, not the Wayland one.
  # The actual socket lives at /mnt/wslg/runtime-dir/wayland-0,
  # but wl-clipboard expects it under $XDG_RUNTIME_DIR.
  systemd.user.services.wslg-wayland-socket = {
    description = "Symlink WSLg Wayland socket";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/ln -sf /mnt/wslg/runtime-dir/wayland-0 %t/wayland-0";
    };
  };

  system.stateVersion = "25.05";
}
