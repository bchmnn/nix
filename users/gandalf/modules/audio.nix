{
  xdg.configFile."wireplumber/wireplumber.conf.d/51-scarlett-samplerate.conf" = {
    text = ''
      monitor.alsa.rules = [
        {
          matches = [
            {
              node.nick = "Scarlett 2i2 USB"
            }
          ]
          actions = {
            update-props = {
              audio.rate = 44100
              api.acp.probe-rate = 44100
            }
          }
        }
      ]
    '';
  };
}
