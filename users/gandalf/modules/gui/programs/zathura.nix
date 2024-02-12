{ ... }: {
  # a highly customizable and functional pdf viewer
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
