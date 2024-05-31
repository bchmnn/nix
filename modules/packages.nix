{ lib, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; with config.bchmnn; [
    pciutils # a collection of programs for inspecting and manipulating configuration of pci devices
    usbutils # tools for working with usb devices, such as lsusb
    lshw # provide detailed information on the hardware configuration of the machine
    git # distributed version control system
    gnumake # a tool to control the generation of non-source files from sources
    parallel # shell tool for executing jobs in parallel
    mercurial # a fast, lightweight scm system for very large distributed projects
    wget # tool for retrieving files using http, https, and ftp
    neofetch # a fast, highly customizable system info script
    lsd # the next gen ls command
    eza # a modern, maintained replacement for ls
    ripgrep # a utility that combines the usability of the silver searcher with the raw speed of grep
    ripgrep-all # ripgrep, but also search in pdfs, e-books, office documents, zip, tar.gz, and more
    expect # a tool for automating interactive applications
    jq # a lightweight and flexible command-line json processor
    unzip # an extraction utility for archives compressed in .zip format
    unrar # utility for rar archives
    libsecret # a library for storing and retrieving passwords and other secrets
    xidel # command line tool to download and extract data from html/xml pages as well as json apis
    nvd # nix/nixos package version diff tool
    inotify-tools # a c library and a set of command-line programs providing a simple interface to inotify
    wireguard-tools # tools for the wireguard secure network tunnel
    mkcert # a simple tool for making locally-trusted development certificates
  ] ++ lib.optionals (devenv.enable) [
    # languages
    gcc13
    clang
    universal-ctags # a maintained ctags implementation
    rustc
    cargo # downloads your rust project's dependencies and builds your project
    go # go programming language
    (python312.withPackages (p: with p; [
      ptpython # an advanced python repl
      ipython # ipython: productive interactive computing
      pycryptodome # self-contained cryptographic library
      gmpy2 # interface to gmp, mpfr, and mpc for python 3.7+
    ]))
    lua
    nixpkgs-fmt
    openjdk17
    javaPackages.openjfx17
    gradle_7
    nodejs_20
    nodenv
    nodePackages.yarn
    nodePackages.pnpm
    mongodb-compass
    ghidra-bin
    hexedit
  ] ++ lib.optionals (gui.enable) [
    libnotify # a library that sends desktop notifications to a notification daemon
    xdg-utils # a set of command line tools that assist applications with a variety of desktop integration tasks
  ] ++ lib.optionals (gui.enable && lib.elem "sway" gui.flavour) [
    qt5.qtwayland
    qt6.qtwayland
  ] ++ lib.optionals (nvidia.enable) [
    nvtopPackages.full
  ];
}
