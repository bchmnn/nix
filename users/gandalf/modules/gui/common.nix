{ pkgs, lib, ... }: {
  colorschemes = rec {
    custom = {
      black = "#000000";
      white = "#ffffff";

      # https://yeun.github.io/open-color/
      active = "#ffdeeb"; # pink1
      activeDark = "#f783ac"; # pink4
      _activeDark = "f783ac"; # pink4
      inactive = "#495057"; # gray7
      inactiveDark = "#212529"; # gray9
      alert = "#c92a2a"; # red9
    };
    default = custom;
  };

  font = "DejaVuSansM Nerd Font";
  font-size = "14";
  gtk = "Adwaita";

  wallpaper = pkgs.fetchurl {
    url = "https://live.staticflickr.com/65535/52797919139_2444712a38_o_d.png";
    sha256 = "1a9148d8911fa25afa82d3b843ee620173955a7ca705d525f3e9d00e00696308";
    meta.licenses = lib.licenses.cc0;
  };
}
