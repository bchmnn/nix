{ pkgs, config, ... }: with config.bchmnn; {
  powerManagement = {
    enable = true;
  };

  services.tlp = {
    enable = !builtins.elem "gnome" gui.flavour;
    settings = power.tlp.settings;
  };

  environment.systemPackages = with pkgs; [
    powertop
  ];
}
