{ nixosConfig, lib, pkgs, ... }: lib.mkIf nixosConfig.bchmnn.games.enable {
  home.packages = with pkgs; [
    extremetuxracer
  ];
}
