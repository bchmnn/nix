{ ... }: {

  services.kanshi = {
    enable = true;

    profiles = {

      nomad = {
        outputs = [
          {
            criteria = "LVDS-1";
            status = "enable";
          }
        ];
      };

      iroh = {
        outputs = [
          {
            criteria = "DP-3";
            status = "enable";
            mode = "2560x1440";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            status = "enable";
            mode = "2560x1440";
            position = "2560,0";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "2560x1440";
            position = "5120,0";
          }
        ];
      };

      station = {
        outputs = [
          {
            criteria = "LVDS-1";
            status = "disable";
          }
          {
            criteria = "DP-3";
            # criteria = "Dell Inc. DELL U2515H 9X2VY5490XUL";
            status = "enable";
            mode = "1920x1080";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            # criteria = "Dell Inc. DELL U2515H 9X2VY5C7138L";
            status = "enable";
            mode = "1920x1080";
            position = "1920,0";
          }
          {
            criteria = "VGA-1";
            # criteria = "HJW VGA TO HDMI 0x00000100";
            status = "enable";
            mode = "1920x1080";
            position = "3840,0";
          }
        ];
      };
    };
  };
}
