{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pnpm
    # pipx-1.14.0's tests/test_inject.py passes argnames with a trailing comma
    # (`"pkg_spec,"`), which pytest 9.1 reads as a tuple form and unpacks, failing
    # at collection time. nixpkgs already excludes these tests via disabledTests,
    # but that expands to -k and cannot suppress a collection error, so the whole
    # file has to be ignored. Drop this override once nixpkgs ships pipx>=1.14.1
    # (nixpkgs#536749).
    (pipx.overridePythonAttrs (old: {
      disabledTestPaths = (old.disabledTestPaths or [ ]) ++ [
        "tests/test_inject.py"
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
