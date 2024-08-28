{ pkgs, ... }: {

  home.packages = with pkgs; [
    mediainfo
    exiftool
  ];

  programs.yazi = {
    enable = true;
  };

}
