{ ... }: {

  /*
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
  */

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
