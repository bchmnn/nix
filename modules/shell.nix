{ pkgs, ... }:
let
  aliases = import ./aliases.nix;
in
{
  programs.zsh = {
    enable = true;
  };

  users.users.gandalf = {
    shell = pkgs.zsh;
  };

  environment = {
    shellAliases = aliases;
  };

  programs.htop = {
    enable = true;
  };

}
