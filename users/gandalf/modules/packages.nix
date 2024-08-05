{ pkgs, ... }: {

  home.packages = with pkgs; [
    gopass # slightly more awesome standard unix password manager for teams. written in go
    gopass-jsonapi # enables communication with gopass via json messages
    yt-dlp # command-line tool to download videos from youtube.com and other sites (youtube-dl fork)
    ranger # a vim-inspired filemanager for the console 
    gdu # fast disk usage analyzer with console interface written in go
    duf # disk usage/free utility - a better 'df' alternative
    stress # simple workload generator for posix systems. it imposes a configurable amount of cpu, memory, i/o, and disk stress on the system
    s-tui # stress-terminal ui monitoring tool
    fio # flexible io tester - an io benchmark tool
    ffmpeg # complete, cross-platform solution to record, convert and stream audio and video
    texliveFull # tex live environment
    imagemagick # software suite to create, edit, compose, or convert bitmap images
    ghostscript # postscript interpreter (mainline version)
    pdftk # command-line tool for working with pdfs
    ventoy-full # bootable usb solution
    unstable.isisdl # downloader for isis of tu-berlin
    sage # open source mathematics software, free alternative to magma, maple, mathematica, and matlab
    filebrowser # filebrowser is a web application for managing files and directories
  ];

}
