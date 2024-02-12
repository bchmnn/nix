{ lib, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; with config.bchmnn; [
    pciutils # A collection of programs for inspecting and manipulating configuration of PCI devices
    usbutils # Tools for working with USB devices, such as lsusb
    git # Distributed version control system
    gnumake # A tool to control the generation of non-source files from sources
    mercurial # A fast, lightweight SCM system for very large distributed projects
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    neofetch # A fast, highly customizable system info script
    lsd # The next gen ls command
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    expect # A tool for automating interactive applications
    jq # A lightweight and flexible command-line JSON processor
    unzip # An extraction utility for archives compressed in .zip format
    libsecret # A library for storing and retrieving passwords and other secrets
    xidel # Command line tool to download and extract data from HTML/XML pages as well as JSON APIs
    nvd # Nix/NixOS package version diff tool
    inotify-tools # a C library and a set of command-line programs providing a simple interface to inotify
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
    nodePackages.yarn
    nodePackages.pnpm
  ] ++ lib.optionals (gui.enable) [
    libnotify # A library that sends desktop notifications to a notification daemon
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
  ] ++ lib.optionals (gui.enable && lib.elem "sway" gui.flavour) [
    qt5.qtwayland
    qt6.qtwayland
  ];
}
