{ ... }: {
  # Enable keyd and remap keys
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        leftalt = "layer(meta)";
        leftmeta = "layer(alt)";
        altgr = "layer(control)";
        rightalt = "layer(control)";
        capslock = "layer(nav)";
      };
      meta = {
        capslock = "overload(nav, capslock)";
      };
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
    };
  };
}
