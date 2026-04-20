{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [
      # denops.vim runtime
      deno
      # LSP servers
      roslyn-ls
      gopls
      vtsls
      lua-language-server
      nixd
      pyright
      ruff
      ty
      vscode-langservers-extracted
      yaml-language-server
      terraform-ls
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/config";
  xdg.configFile."nvim/init.lua" = lib.mkForce { enable = false; };
}
