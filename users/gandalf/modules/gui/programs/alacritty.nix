{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        # Available themes:
        #   https://github.com/alacritty/alacritty-theme

        "${pkgs.alacritty-theme}/atom_one_light.toml"
      ];
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        normal = {
          family = common.font;
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
