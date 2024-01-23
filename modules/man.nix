{ pkgs, ... }: {

  documentation = {
    enable = true;
    doc.enable = true;
    dev.enable = true;
    man.enable = true;
  };

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    ncurses
  ];

}
