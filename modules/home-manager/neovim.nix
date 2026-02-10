{ config, pkgs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
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
      pyright
      ruff
      terraform-ls
      vscode-langservers-extracted
      vtsls
      yaml-language-server
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/nvim";
}
