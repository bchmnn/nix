{ lib, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; with config.bchmnn; [
    pciutils
    usbutils
    git
    gnumake
    mercurial # contains 'hg'
    wget
    neofetch
    lsd
    ripgrep
    expect # contains 'unbuffer'
    jq # parse json
    unzip
    libsecret
  ] ++ lib.optionals (devenv.enable) [
    # languages
    gcc13
    rustc
    cargo
    go
    python312
    lua
    nixpkgs-fmt
    openjdk17
    javaPackages.openjfx17
    gradle_7
    nodejs_21
    nodenv
  ] ++ lib.optionals (gui.enable) [
    libnotify
    glib # gsettings
    xdg-utils # for opening default programs
  ] ++ lib.optionals (gui.enable && lib.elem "sway" gui.flavour) [
    qt5.qtwayland
    qt6.qtwayland
  ];
}
