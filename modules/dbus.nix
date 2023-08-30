{ pkgs, ... }: {
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ]; # needed for gnome pinentry
  };
}
