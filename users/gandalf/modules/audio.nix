{
  xdg.configFile."wireplumber/wireplumber.conf.d/51-scarlett-samplerate.conf" = {
    text = ''
      monitor.alsa.rules = [
        {
          matches = [
            {
              node.name = "~alsa_input.pci.*"
              cpu.vm.name = "~.*"
            }
            {
              node.name = "~alsa_output.pci.*"
              cpu.vm.name = "~.*"
            }
          ]
          actions = {
            update-props = {
              api.alsa.period-size            = 2048
              api.alsa.headroom               = 2048
              session.suspend-timeout-seconds = 0
            }
          }
        }
        # {
        #   matches = [
        #     {
        #       node.nick = "Scarlett 2i2 USB"
        #     }
        #   ]
        #   actions = {
        #     update-props = {
        #       audio.rate = 48000
        #       api.acp.probe-rate = 48000
        #     }
        #   }
        # }
      ]
    '';
  };
}
