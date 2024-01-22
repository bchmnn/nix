{ pkgs, nixosConfig }:

pkgs.writeShellScriptBin "nuf" ''
  reset="\e[0m"
  red="\e[31m"
  green="\e[32m"
  yellow="\e[33m"
  white_bold="\e[1;37m"

  function error {
    echo ""
    echo -e "''${red}>>> ''${bold}Error''${reset}''${red}: $1''${reset}"
    exit 1
  }

  FLAKE=$(readlink -f /etc/nixos)

  echo -e "''${green}>>> Updating flake $FLAKE ...''${reset}"
  ${nixosConfig.nix.package}/bin/nix flake update --flake "$FLAKE" || error "Updating failed"

  cd $(mktemp -d)
  echo ""
  echo -e "''${green}>>> Building configuration ...''${reset}"
  nixos-rebuild build --flake "$FLAKE" || error "Building failed"

  echo ""
  echo -e "''${green}>>> Running diff ...''${reset}";
  ${pkgs.nvd}/bin/nvd diff /run/current-system result || error "Diff failed"

  cd - > /dev/null

  echo ""
  echo -e "''${yellow}>>> The new configuration has not been activated.''${reset}"
  echo -e "''${yellow}>>> Use ''${white_bold}nixos-rebuild switch''${reset}''${yellow} to activate.''${reset}"
''
