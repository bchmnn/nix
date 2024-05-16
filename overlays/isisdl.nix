{ lib
, buildPythonApplication
, fetchPypi
, cryptography
, requests
, pyyaml
, packaging
, colorama
, pyinotify
, distro
, psutil
}:
buildPythonApplication rec {
  pname = "isisdl";
  version = "1.3.19";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VcqaFqcoH+d1NpKq7QBVbXcbe0HfZ67kStGFiYmr/kE=";
  };

  propagatedBuildInputs = [
    cryptography
    requests
    pyyaml
    packaging
    colorama
    pyinotify
    distro
    psutil
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/Emily3403/isisdl";
    description = "A downloader for ISIS of TU-Berlin";
    license = licenses.mit;
  };
}
