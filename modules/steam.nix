{ config, lib, ... }: lib.mkIf config.bchmnn.games.enable {
  programs.steam = {
    enable = true;
  };
}
