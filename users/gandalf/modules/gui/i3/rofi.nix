{ config, pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    font = common.font + " " + common.font-size;
    location = "center";
    extraConfig = {
      show-icons = mkLiteral "true";
    };
    theme = {
      "prompt" = {
        "text-color" = mkLiteral common.colorschemes.default.inactive;
      };
      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        "text-color" = mkLiteral common.colorschemes.default.inactive;
      };
      "inputbar" = {
        "padding" = mkLiteral "10px 20px 10px 20px";
        "border" = mkLiteral "0px 0px 1px dash 0px";
        "border-color" = mkLiteral common.colorschemes.default.activeDark;
        "children" = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" ];
      };
      "listview" = {
        "padding" = mkLiteral "10px";
      };
      "element" = {
        "padding" = mkLiteral "10px";
      };
      "element-text" = {
        "margin" = mkLiteral "0px 0px 0px 20px";
      };
    } // lib.foldl'
      (acc: elem: acc // {
        ${elem} = { "background-color" = mkLiteral common.colorschemes.default.activeDark; };
      })
      { }
      (lib.mapCartesianProduct ({ a, b, c }: lib.concatStringsSep "." [ a b c ]) {
        a = [ "element" "element-text" "element-icon" ];
        b = [ "selected" ];
        c = [ "normal" "urgent" "active" ];
      });
  };
}
