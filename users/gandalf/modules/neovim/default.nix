{ pkgs, ... }: {

  /*
    xdg.configFile."nvim" = {
      source = ./config;
      recursive = true;
    };
  */

  home.packages = with pkgs; [
    tree-sitter # parser generator tool and an incremental parsing library
    lua-language-server # language server that offers lua language support
    clang-tools # standalone command line tools for c++ development
    rust-analyzer # modular compiler frontend for the rust language
    rustfmt # tool for formatting rust code according to style guidelines
    gopls # official language server for the go language
    nixd # nix language server
    nodePackages.pyright # type checker for the python language
    ruff # an extremely fast python linter
    black # uncompromising python code formatter
    isort # python utility / library to sort python imports
    vscode-langservers-extracted # html/css/json/eslint language servers extracted from vscode
    nodePackages.typescript-language-server
    tailwindcss-language-server
    nodePackages.prettier # prettier is an opinionated code formatter
    prettierd # prettier, as a daemon, for improved formatting speed
    texlab # implementation of the language server protocol for latex
    yamlfmt # extensible command line tool or library to format yaml files
    yamlfix # python yaml formatter that keeps your comments
    marksman # language server for markdown
    markdownlint-cli2 # fast, flexible, configuration-based command-line interface for linting markdown/commonmark files with the markdownlint library
    mdformat # commonmark compliant markdown formatter
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;
  };

}
