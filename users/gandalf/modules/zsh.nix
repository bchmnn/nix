{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    /*
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          hash = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
    ];
    */
    oh-my-zsh = {
      enable = true;
      theme = "terminalparty";
      plugins = [
        "git"
      ];
    };
    history = {
      path = "${config.xdg.dataHome}/zsh/histfile";
      size = 10000;
      save = 10000;
    };
  };
}
