{ pkgs, ... }: {

  /*
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
  */

  home.packages = with pkgs; [
    tree-sitter # parser generator tool and an incremental parsing library
    lua-language-server
    clang-tools
    rust-analyzer
    rustfmt
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
