{ ... }: {
  security.polkit.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  # TODO workaround to get swaylock accepting pw
  # https://github.com/NixOS/nixpkgs/issues/158025
  security.pam.services.swaylock = {};

}
