{ pkgs, ... }:

# https://nixos.wiki/wiki/Qt
# https://nixos.org/manual/nixpkgs/stable/#sec-language-qt
pkgs.libsForQt5.callPackage ./build.nix { }
