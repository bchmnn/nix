{ ... }: {

  programs.autorandr = {
    enable = true;

    profiles = {

      nomad = {
        config = {
          "LVDS-1" = {
            enable = false;
          };
        };
      };

      samsung = {
        fingerprint = {
          "HDMI-1" = "00ffffffffffff004c2d830e000e0001011c0103806b3c780a23ada4544d99260f474abdef80714f81c0810081809500a9c0b300010104740030f2705a80b0588a00501d7400001e023a801871382d40582c4500501d7400001e000000fd00184b0f511e000a202020202020000000fc0053414d53554e470a202020202001b902034cf0535f101f041305142021225d5e626364071603122909070715075057070183010000e2004fe30503016e030c001000b83c20008001020304e3060d01e50e60616566e5018b849001011d80d0721c1620102c2580501d7400009e662156aa51001e30468f3300501d7400001e000000000000000000000000000000a3";
        };
        config = {
          "HDMI-0" = {
            enable = true;
            primary = true;
            mode = "3840x2160";
            rate = "59.94";
            position = "0x0";
          };
        };
      };

      station = {
        config = {
          "LVDS-1" = {
            enable = false;
          };
          "DP-1-3" = {
            enable = false;
            mode = "1920x1080";
            position = "0x0";
          };
          "DP-1-2" = {
            enable = false;
            mode = "1920x1080";
            position = "1920x0";
          };
          "VGA-1-2" = {
            enable = false;
            mode = "1920x1080";
            position = "3840x0";
          };
        };
      };
    };
  };

}
