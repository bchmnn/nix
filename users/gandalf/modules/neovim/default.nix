{ pkgs, ... }: {

  /*
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
  */

  home.packages = with pkgs; [
    lua-language-server
    clang-tools
    rust-analyzer
    gopls
    nixd
    nodePackages_latest.typescript-language-server
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
