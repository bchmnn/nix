{ pkgs }:

pkgs.writeShellScriptBin "git-clone-list" ''
  reset="\e[0m"
  bold="\e[1m"
  underline="\e[4m"
  red="\e[31m"
  green="\e[32m"

  function help_screen {
    echo
    echo -e "''${bold}''${underline}Usage:''${reset} ''${bold}$0''${reset} <USER> <LIST>"
    echo
    echo -e "''${bold}''${underline}Arguments''${reset}:"
    echo -e "  ''${bold}USER''${reset}  Github username of target user"
    echo -e "  ''${bold}LIST''${reset}  List name of target list"
    echo
  }

  function error {
    echo
    echo -e "''${red}>>> ''${bold}Error''${reset}''${red}: $1''${reset}"
    if [ "$2" == "help" ]; then
      help_screen
    fi
    exit 1
  }

  if [ $# -ne 2 ]; then
    error "Expected 2 arguments, got $#" help
  fi

  USER=$1
  LIST=$2

  echo -e "''${green}>>> Fetching list https://github.com/stars/$USER/lists/$LIST ...''${reset}"
  REPOS=$(${pkgs.xidel}/bin/xidel https://github.com/stars/$USER/lists/$LIST --xpath '//*[@id="user-list-repositories"]//a[not(@class)]/@href')

  NUM_REPOS=$(echo $REPOS | wc -w)
  IT=1

  for repo in $REPOS; do
    echo -e "''${green}>>> [$IT/$NUM_REPOS] Cloning: https://github.com$repo.git ...''${reset}"
    ${pkgs.git}/bin/git clone "https://github.com$repo.git" "''${repo:1}"
    IT=$((IT + 1))
  done
''
