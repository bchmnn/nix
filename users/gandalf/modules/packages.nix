{ pkgs, ... }: {

  home.packages = with pkgs; [
    gopass # slightly more awesome standard unix password manager for teams. written in go
    gopass-jsonapi # enables communication with gopass via json messages
    yt-dlp # command-line tool to download videos from youtube.com and other sites (youtube-dl fork)
    ranger # a vim-inspired filemanager for the console 
    gdu # fast disk usage analyzer with console interface written in go
    duf # disk usage/free utility - a better 'df' alternative
    phoronix-test-suite # the phoronix test suite open-source, cross-platform automated testing/benchmarking software
    ffmpeg # complete, cross-platform solution to record, convert and stream audio and video
    texliveFull # tex live environment
    imagemagick # software suite to create, edit, compose, or convert bitmap images
  ];

}
