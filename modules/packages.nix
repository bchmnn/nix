{ lib, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; with config.bchmnn; [
    pciutils
    usbutils
    git
    mercurial # contains 'hg'
    wget
    neofetch
    lsd
    ripgrep
    expect # contains 'unbuffer'
    jq # parse json
  ] ++ lib.optionals (devenv.enable) [
    # languages
    gcc13
    go
    openjdk17
    javaPackages.openjfx17
    gradle_7
    python312
    nodenv
    rustc
    cargo
  ] ++ lib.optionals (gui.enable) [
    libnotify
    glib # gsettings
    xdg-utils # for opening default programs
  ] ++ lib.optionals (gui.enable && lib.elem "sway" gui.flavour) [
    qt5.qtwayland
    qt6.qtwayland
  ];
}
