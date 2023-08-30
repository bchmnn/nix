{ ... }: {
  security.polkit.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
}
