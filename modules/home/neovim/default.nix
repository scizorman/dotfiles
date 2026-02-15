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
      lua-language-server
      nixd
      pyright
      ruff
      terraform-ls
      vscode-langservers-extracted
      vtsls
      yaml-language-server
    ];
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/config";
}
