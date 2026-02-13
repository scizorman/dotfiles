{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    google-cloud-sdk
  ];

  programs.zsh = {
    initContent = ''
      autoload -Uz bashcompinit && bashcompinit
      complete -C "$(which aws_completer)" aws
    '';
  };
}
