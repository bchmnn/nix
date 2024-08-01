{ pkgs, lib, buildPythonApplication, python3Packages }:
buildPythonApplication {
  pname = "pppdf";
  version = "1.0.0";
  src = ./pppdf.py;

  nativeBuildInputs = [
    pkgs.wrapGAppsHook
    pkgs.gobject-introspection
  ];

  propagatedBuildInputs = with python3Packages; [
    pkgs.gtk3
    pygobject3
    notify2
    pikepdf
  ];

  dontUnpack = true;
  format = "other";

  installPhase = ''
    install -D $src $out/bin/pppdf
  '';

  meta = with lib; {
    description = "PDF Postprocessor";
    license = licenses.mit;
  };

}
