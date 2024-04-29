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
    typescript
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
