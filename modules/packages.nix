{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pciutils
    qt6.qtwayland
    xdg-utils # for opening default programs
    glib # gsettings
    git
    mercurial # contains 'hg'
    wget
    neofetch
    lsd
    ripgrep
    expect # contains 'unbuffer'
    # languages
    gcc13
    go
    openjdk17
    javaPackages.openjfx17
    gradle_7
    python312
    nodejs_20
  ];
}
