{ ... }:

{
  programs.eza = {
    enable = true;
  };

  programs.zsh.shellAliases = {
    ls = "eza";
    ll = "eza --classify --git --long";
    la = "eza --all --classify";
    lla = "eza --all --classify --git --long";
    tree = "eza --git-ignore --tree";
  };
}
