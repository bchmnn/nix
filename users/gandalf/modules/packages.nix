{ pkgs, ... }: {

  home.packages = with pkgs; [
    gopass
    gopass-jsonapi
    yt-dlp
  ];

}
