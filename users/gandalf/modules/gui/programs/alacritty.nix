{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
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
