{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghq
  ];

  programs.zsh.initContent = ''
    function ghq-cd() {
      local dir="$(ghq list -p | fzf)"
      [[ -n "''${dir}" ]] && cd "''${dir}"
    }
    alias gl='ghq-cd'
  '';
}
