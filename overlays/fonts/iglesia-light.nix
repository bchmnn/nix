{ pkgs }: pkgs.stdenv.mkDerivation {
  pname = "iglesia-light-typeface";
  version = "1.009";

  src = ./iglesia-light.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 Iglesia\ Light.ttf -t $out/share/fonts/truetype
    runHook postInstall
  '';
}
