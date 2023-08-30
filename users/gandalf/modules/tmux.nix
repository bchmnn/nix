{
  programs.tmux = {
    enable = true;
    newSession = true;
    terminal = "screen-256color";

    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;

    mouse = true;
    keyMode = "vi";
  };
}
