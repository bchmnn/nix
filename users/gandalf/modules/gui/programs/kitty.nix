{ pkgs, lib, ... }:
let
  common = (import ../common.nix) { pkgs = pkgs; lib = lib; };
  kitty-alabaster-theme-patch = builtins.toFile "kitty-theme-alabaster.patch" ''
    diff --git a/themes/Alabaster.conf b/themes/Alabaster.conf
    index 7989049..b0c180e 100644
    --- a/themes/Alabaster.conf
    +++ b/themes/Alabaster.conf
    @@ -6,17 +6,17 @@
     
     #: The basic colors
     
    -foreground              #000000
    -background              #f7f7f7
    +foreground              #434343
    +background              #ffffff
     
    -selection_foreground    #000000
    +selection_foreground    #434343
     selection_background    #bfdbfe
     
     
     #: Cursor colors
     
    -cursor                  #007acc
    -cursor_text_color       #bfdbfe
    +cursor                  #434343
    +cursor_text_color       #ffffff
     
     
     #: URL underline color when hovering with mouse
    @@ -55,8 +55,8 @@ color6                  #0083b2
     color14                 #00aacb
     
     #: white
    -color7                  #f7f7f7
    -color15                 #f7f7f7
    +color7                  #bbbbbb
    +color15                 #ffffff
     
     
     #: kitty window border colors and terminal bell colors
  '';
  kitty-theme-patched = pkgs.kitty-themes.overrideAttrs (final: previous: {
    patches = [
      kitty-alabaster-theme-patch
    ];
  });
in
{
  programs.kitty = {
    enable = true;
    font.name = common.font;
    font.size = 12;
    extraConfig = ''
      include ${kitty-theme-patched}/share/kitty-themes/themes/Alabaster.conf
    '';
  };
}
