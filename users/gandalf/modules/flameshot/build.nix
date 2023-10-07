{ pkgs , cmake , qttools , qtsvg , kguiaddons , wrapQtAppsHook }:

# https://ryantm.github.io/nixpkgs/using/overrides/
pkgs.flameshot.overrideAttrs (finalAttrs: previousAttrs: {

  pname = previousAttrs.pname + "-wl";

  nativeBuildInputs = [ cmake qttools qtsvg kguiaddons wrapQtAppsHook ];
  cmakeFlags = [
    "-DUSE_WAYLAND_CLIPBOARD=1"
    "-DUSE_WAYLAND_GRIM=1"
  ];

})
