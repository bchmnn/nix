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
    xidel # xml parser
    nvd # nix diff package versions between two store paths
    inotify-tools # set of command-line programs providing a simple interface to inotify
  ] ++ lib.optionals (devenv.enable) [
    # languages
    gcc13
    clang
    rustc
    cargo
    go
    python312
    lua
    nixpkgs-fmt
    openjdk17
    javaPackages.openjfx17
    gradle_7
    bun-baseline
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
