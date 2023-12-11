{ ... }: let
  nav = {
    h = "left";
    j = "down";
    k = "up";
    l = "right";
    "0" = "home";
    "4" = "end";
    u = "pageup";
    d = "pagedown";
  };
  alt = {
    a = "";
    o = "";
    u = "";
    s = "";
    e = "";
  };
  altShift = {
    a = "";
    o = "";
    u = "";
  };
in {
  # Enable keyd and remap keys
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" "-04fe:0020" ];
      settings = {
        main = {
          leftalt = "layer(meta)";
          leftmeta = "layer(alt)";
          altgr = "layer(control)";
          rightalt = "layer(control)";
          capslock = "layer(nav)";
        };
        alt = alt;
        "alt+shift" = altShift;
        meta = {
          capslock = "overload(nav, capslock)";
        };
        nav = nav;
      };
    };
    keyboards.hhkb = {
      ids = [ "04fe:0020" ];
      settings = {
        main = {
          rightmeta = "layer(control)";
          leftcontrol = "layer(nav)";
        };
        alt = alt;
        "alt+shift" = altShift;
        meta = {
          leftcontrol = "overload(nav, capslock)";
        };
        nav = nav;
      };
    };
  };
}
