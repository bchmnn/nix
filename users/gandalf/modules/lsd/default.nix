{ ... }: {

  xdg.configFile."lsd/colors.yaml" = {
    source = ./light.yaml;
  };

  programs.lsd = {
    enable = true;
    settings = {
      color = {
        theme = "custom";
      };
    };
  };

}
