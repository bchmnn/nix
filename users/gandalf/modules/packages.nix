{ pkgs, ... }: {

  home.packages = with pkgs; [
    gopass
    gopass-jsonapi
    yt-dlp
    gdu # fast disk usage analyzer with console interface written in go
    duf # disk usage/free utility - a better 'df' alternative 
  ];

}
