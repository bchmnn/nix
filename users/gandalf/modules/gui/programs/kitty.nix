{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{
  programs.kitty = {
    enable = true;
    font.name = common.font;
    font.size = 12;
    theme = "Tango Light";
  };
}
