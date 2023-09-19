{ pkgs, ... }: {

  home.packages = with pkgs; [
    swaynotificationcenter
    libnotify
  ];

  xdg.configFile = {
    "swaync/config.json".source = ./config.json;
    "swaync/style.css".source = ./style.css;
  };

}
