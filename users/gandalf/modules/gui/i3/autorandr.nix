{ ... }: {

  programs.autorandr = {
    enable = true;

    profiles = {

      nomad = {
        config = {
          "LVDS-1" = {
            enable = true;
          };
        };
      };

      station = {

        config = {
          "LVDS-1" = {
            enable = false;
          };
          "DP-1-3" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
          };
          "DP-1-2" = {
            enable = true;
            mode = "1920x1080";
            position = "1920x0";
          };
          "VGA-1-2" = {
            enable = true;
            mode = "1920x1080";
            position = "3840x0";
          };
        };
      };
    };
  };

}
