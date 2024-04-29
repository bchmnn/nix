{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{

  programs.rofi = {
    enable = true;
    font = common.font;
    location = "center";
  };

}
