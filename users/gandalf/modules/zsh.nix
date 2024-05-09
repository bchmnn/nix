{ config, pkgs, ... }: {
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

    initExtra = ''
      nix_dev_env() {
        FLAKE="$PWD/flake.nix"
        [[ -z "$CURRENT_FLAKE_ENV" ]]          && \
        [[ -f $FLAKE ]]                        && \
          ZSH_PREFIX="$ZSH_PREFIX(flake)"         \
          CURRENT_FLAKE_ENV=$FLAKE                \
          nix develop -c $SHELL 2> /dev/null
      }
      autoload -U add-zsh-hook
      add-zsh-hook chpwd nix_dev_env

      export PS1="$ZSH_PREFIX$PS1"
    '';
  };
}
