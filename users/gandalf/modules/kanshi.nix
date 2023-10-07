{ ... }: {

  services.kanshi = {
    enable = true;

    profiles = {

      home = {
        outputs = [
          {
            criteria = "DP-3";
            mode = "1920x1080";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            mode = "1920x1080";
            position = "1920,0";
          }
          {
            criteria = "LVDS-1";
            mode = "1920x1080";
            position = "3840,0";
            scale = 1.33;
          }
        ];
      };

    };

  };

}
