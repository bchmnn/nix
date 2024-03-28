{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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
