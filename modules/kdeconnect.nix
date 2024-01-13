{ config, ... }: {
  programs.kdeconnect.enable = config.bchmnn.gui.enable;
}
