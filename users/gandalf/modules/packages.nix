{ pkgs, ... }: {

  home.packages = with pkgs; [
    gopass
    gopass-jsonapi
    yt-dlp
    ranger # a vim-inspired filemanager for the console 
    gdu # fast disk usage analyzer with console interface written in go
    duf # disk usage/free utility - a better 'df' alternative
    phoronix-test-suite # the phoronix test suite open-source, cross-platform automated testing/benchmarking software
    ffmpeg
    texliveFull
  ];

}
