{ pkgs, ... }: {
  # provide libraries for non-nix binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      libcxx
      libllvm
    ];
  };
}
