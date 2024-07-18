{ pkgs, ... }: {
  # Add fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
      comic-relief
      iglesia-light
    ];
  };
}
