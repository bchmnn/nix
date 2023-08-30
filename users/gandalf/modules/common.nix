{
  colorschemes = rec {
    custom = {
      black = "#000000";
      white = "#ffffff";

      # https://yeun.github.io/open-color/
      active = "#ffdeeb"; # pink1
      activeDark = "#f783ac"; # pink4
      inactive = "#495057"; # gray7
      inactiveDark = "#212529"; # gray9
      alert = "#c92a2a"; # red9
    };
    default = custom;
  };

  font = "DejaVuSansM Nerd Font";
  font-size = "14";
  gtk = "Adwaita";
}
