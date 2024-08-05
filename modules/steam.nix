{ pkgs, config, lib, ... }: lib.mkIf config.bchmnn.games.enable {
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode
  ];
}
