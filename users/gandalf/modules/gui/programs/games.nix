{ nixosConfig, lib, pkgs, ... }: lib.mkIf nixosConfig.bchmnn.games.enable {
  home.packages = with pkgs; [
    celestia # real-time 3d simulation of space
    extremetuxracer # high speed arctic racing game based on tux racer
  ];
}
