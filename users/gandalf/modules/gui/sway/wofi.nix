{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
in
{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true;
      image_size = 24;
      no_actions = true;
    };
    style = ''
      * {
        font-family: '${common.font}', monospace;
        font-size: ${common.font-size}px;
        color: ${common.colorschemes.default.black};
      }

      window {
        background-color: transparent;
      }

      #input {
        background-color: ${common.colorschemes.default.active};
        border: 5px;
        border-color: ${common.colorschemes.default.activeDark};
        border-radius: 0px;
        padding-top: 10px;
        padding-bottom: 10px;
        padding-left: 20px;
        padding-right: 20px;
        margin-bottom: 10px;
      }

      #scroll {
        background-color: ${common.colorschemes.default.active};
        border: 5px;
        border-color: ${common.colorschemes.default.activeDark};
        border-radius: 0px;
        padding: 10px;
      }

      #entry {
        padding: 10px;
      }

      #entry #text {
        margin-left: 20px;
      }

      #entry:selected {
        background-color: ${common.colorschemes.default.activeDark};
      }

      #entry:selected #img {
        background-color: ${common.colorschemes.default.activeDark};
      }

      #entry:selected #text {
        background-color: ${common.colorschemes.default.activeDark};
      }
    '';
  };
}
