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
let
  remove-completion-patch = builtins.toFile "remove-completion-patch" ''
    diff --git a/src/isisdl/utils.py b/src/isisdl/utils.py
    index 691e18f..8597bf0 100644
    --- a/src/isisdl/utils.py
    +++ b/src/isisdl/utils.py
    @@ -399,55 +399,6 @@ def startup() -> None:
                 with open(config_file_location, "w") as f:
                     f.write(f"# You probably want to start by copying {example_config_file_location} and adapting it.\n")
     
    -    if not is_windows and not is_static:
    -        # Install completions if they don't exist already
    -        user_dir = os.path.expanduser("~")
    -
    -        if shutil.which("zsh") is not None:
    -            default_path = f"{user_dir}/.local/share/zsh/site-functions"
    -            whitelist_paths = [
    -                f"{user_dir}/.oh-my-zsh/completions",
    -                f"{user_dir}/.oh-my-zsh/custom/plugins/zsh-completions/src",
    -            ]
    -
    -            # Since the session is interactive it might contain stuff like neofetch etc.
    -            rand_string = "".join(random.choice(string.ascii_letters) for _ in range(32))
    -            fpath = subprocess.check_output(["zsh", "-c", "-i", f"echo {rand_string}; echo $FPATH"]) \
    -                .decode().split(rand_string)[-1].strip().split(":")
    -
    -            # 1. Find install path (default .local/share/zsh/site-functions or .local/share/isisdl/)
    -            # 2. copy _isisdl there
    -
    -            # 3. Export this path to $FPATH via .zshrc (make this transparent to user)
    -            # 4. autoload [path]/_isisdl
    -
    -            for final_path in whitelist_paths:
    -                for p in fpath:
    -                    if final_path == p and not (os.path.exists(final_path) and not os.access(final_path, os.W_OK | os.X_OK)):
    -                        break
    -
    -            else:
    -                final_path = default_path
    -
    -            # Here the file is always copied to the destination dir.
    -            # This is fine since the Filesystem will (hopefully) realize that the files are the same and thus ignore it.
    -            os.makedirs(final_path, exist_ok=True)
    -
    -            completion_source = source_code_location.joinpath("resources", "completions", "zsh", "_isisdl")
    -            if completion_source.exists():
    -                shutil.copy(completion_source, final_path)
    -
    -            # TODO: Also tag this file as autoloadable
    -
    -        if shutil.which("fish") is not None:
    -            # TODO
    -            pass
    -
    -        if shutil.which("bash") is not None:
    -            final_path = f"{user_dir}/.local/share/bash-completion/completions"
    -            os.makedirs(final_path, exist_ok=True)
    -            shutil.copy(source_code_location.joinpath("resources", "completions", "zsh", "_isisdl"), final_path)
    -
     
     def clear() -> None:
         if is_windows:
  '';
in
buildPythonApplication rec {
  pname = "isisdl";
  version = "1.3.19";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VcqaFqcoH+d1NpKq7QBVbXcbe0HfZ67kStGFiYmr/kE=";
  };

  patches = [
    remove-completion-patch
  ];

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
