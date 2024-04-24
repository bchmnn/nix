{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
  alabaster-theme-patch = builtins.toFile "alabaster.patch" ''
    diff --git a/alabaster.toml b/alabaster.toml
    index df312d3..f5e5499 100644
    --- a/alabaster.toml
    +++ b/alabaster.toml
    @@ -2,11 +2,11 @@
     # author tonsky

     [colors.primary]
    -background = '#F7F7F7'
    +background = '#FFFFFF'
     foreground = '#434343'

     [colors.cursor]
    -text = '#F7F7F7'
    +text = '#FFFFFF'
     cursor = '#434343'

     [colors.normal]
  '';
  alacritty-theme-patched = pkgs.alacritty-theme.overrideAttrs (final: previous: {
    patches = [
      alabaster-theme-patch
    ];
  });
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        # Available themes:
        #   https://github.com/alacritty/alacritty-theme
        "${alacritty-theme-patched}/alabaster.toml"
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
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
