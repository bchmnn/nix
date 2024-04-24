{ pkgs, lib, ... }: {
  colorschemes = rec {
    custom = {
      black = "#000000";
      _black = "000000";
      white = "#ffffff";
      _white = "ffffff";

      # https://yeun.github.io/open-color/
      active = "#ffffff"; # white
      activeDark = "#4276b9"; # blue
      _activeDark = "4276b9"; # blue
      inactive = "#495057"; # gray7
      inactiveDark = "#212529"; # gray9
      alert = "#c92a2a"; # red9

      # active = "#ffdeeb"; # pink1
      # activeDark = "#f783ac"; # pink4
      # _activeDark = "f783ac"; # pink4
      # inactive = "#495057"; # gray7
      # inactiveDark = "#212529"; # gray9
      # alert = "#c92a2a"; # red9
    };
    default = custom;
  };

  font = "DejaVuSansM Nerd Font";
  font-size = "14";
  gtk = "Adwaita";

  wallpaper = rec {
    neptun = pkgs.fetchurl {
      url = "https://live.staticflickr.com/65535/52797919139_2444712a38_o_d.png";
      sha256 = "1a9148d8911fa25afa82d3b843ee620173955a7ca705d525f3e9d00e00696308";
      meta.licenses = lib.licenses.cc0;
    };

    everest = pkgs.fetchurl {
      url = "https://images7.alphacoders.com/546/546508.jpg";
      sha256 = "90774d977a5f9cde2264fc1c46417b34046f491b5caca7805c9cd17e3463777b";
      meta.licenses = lib.licenses.cc0;
    };

    default = everest;
  };
}
