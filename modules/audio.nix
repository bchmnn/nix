{ pkgs, config, lib, ... }: lib.mkIf config.bchmnn.audio.enable {
  # Enable pipewire - audio
  services.pipewire = lib.mkIf (!builtins.elem "gnome" config.bchmnn.gui.flavour) {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    pulseaudio
  ];

}
