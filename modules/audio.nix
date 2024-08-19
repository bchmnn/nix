{ pkgs, config, lib, ... }: lib.mkIf config.bchmnn.audio.enable {
  services.pipewire = lib.mkIf (!builtins.elem "gnome" config.bchmnn.gui.flavour) {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire = lib.mkIf config.bchmnn.audio.pipewire-wine-fix.enable {
      "90-wine-config" = {
        "context.properties" = {
          # "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 ];
          # "default.clock.quantum" = 2048;
          # "default.clock.min-quantum" = 1024;
        };
      };
    };
    extraConfig.pipewire-pulse = lib.mkIf config.bchmnn.audio.pipewire-wine-fix.enable {
      "90-wine-config" = {
        "pulse.properties" = {
          "pulse.min.req" = "1024/48000";
          # "pulse.min.frag" = "1024/48000";
          # "pulse.min.quantum" = "1024/48000";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    pulseaudio
  ];
}
