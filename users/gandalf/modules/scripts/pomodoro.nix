{ pkgs }:
let
  pootis = ./pootis.m4a;
in
[
  (pkgs.writeShellScriptBin
    "pomostart"
    ''
      clear
      ${pkgs.openpomodoro-cli}/bin/openpomodoro-cli start --wait $@
      while ${pkgs.mpv}/bin/mpv ${pootis} > /dev/null 2>&1; do :; done
    '')
  (pkgs.writeShellScriptBin
    "pomobreak"
    ''
      clear
      ${pkgs.openpomodoro-cli}/bin/openpomodoro-cli break --wait $@
      while ${pkgs.mpv}/bin/mpv ${pootis} > /dev/null 2>&1; do :; done
    '')
]
