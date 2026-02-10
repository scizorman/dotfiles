{ pkgs, user, ... }:

let
  pbcopy = pkgs.writeShellScriptBin "pbcopy" user.clipboard.copy;
  pbpaste = pkgs.writeShellScriptBin "pbpaste" user.clipboard.paste;
in
{
  home.packages = [
    pbcopy
    pbpaste
  ];
}
