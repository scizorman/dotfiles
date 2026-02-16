{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      # denops.vim runtime
      deno
      # LSP servers
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
}
