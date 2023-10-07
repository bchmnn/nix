{ pkgs, ... }: {

  home.packages = with pkgs; [
    firefox
    speechd # https://support.mozilla.org/en-US/kb/speechd-setup
    gopass
    gopass-jsonapi
    gnome.nautilus
    gimp
    vlc
    gnome.simple-scan
  ];

}
