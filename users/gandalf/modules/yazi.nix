{ pkgs, ... }: {

  home.packages = with pkgs; [
    exiftool
    mediainfo
    ueberzugpp
  ];

  programs.yazi = {
    enable = true;
  };

}
