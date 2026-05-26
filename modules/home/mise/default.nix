{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pnpm
    # nixpkgs#522307: pipx-1.8.0's tests/test_package_specifier.py expects
    # the pre-PEP 508 `name@ url` form but packaging now emits `name @ url`,
    # which makes 7 tests fail. Drop this override once upstream is fixed.
    (pipx.overridePythonAttrs (old: {
      disabledTests = (old.disabledTests or [ ]) ++ [
        "test_fix_package_name"
        "test_parse_specifier_for_metadata"
      ];
    }))
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."mise/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/mise/config/config.toml";
}
