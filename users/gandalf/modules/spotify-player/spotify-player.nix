{ pkgs, ... }: {

  home.packages = with pkgs; [
    spotify-player
  ];

  xdg.configFile."spotify-player/app.toml".source = ./app.toml;

}
