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
    nodePackages.pyright # type checker for the python language
    ruff # an extremely fast python linter
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers extracted from vscode
    nodePackages.typescript-language-server
    tailwindcss-language-server
    texlab # implementation of the language server protocol for latex
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
