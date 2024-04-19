{ pkgs, ... }: {
  home.pointerCursor = {
    name = "macOS-Monterey";
    package = pkgs.apple-cursor;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };
}
