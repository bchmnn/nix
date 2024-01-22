{ pkgs }:

pkgs.writeShellScriptBin "git-clone-list" ''
  reset="\e[0m"
  bold="\e[1m"
  underline="\e[4m"
  red="\e[31m"
  green="\e[32m"

  XPATH='//*[@id="user-list-repositories"]//a[not(@class)]/@href'

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

  NOT_VISITED=("/stars/$USER/lists/$LIST?page=1")
  VISITED=()
  REPOS=()

  while [[ "''${#NOT_VISITED[@]}" != 0 ]]; do
    echo -e "''${green}>>> Fetching https://github.com''${NOT_VISITED[0]} ...''${reset}"
    while IFS= read -r line; do
      VISITED+=("''${NOT_VISITED[0]}")
      unset NOT_VISITED[0]
      if [[ "$line" == "/stars/$USER/lists/$LIST"* ]]; then
        if [[ ! "''${VISITED[@]}" =~ "''${line}" ]]; then
          NOT_VISITED+=("$line")
        fi
      else
        REPOS+=("$line")
      fi
    done < <(xidel "https://github.com''${NOT_VISITED[0]}" --xpath $XPATH)
  done

  IT=1

  for repo in "''${REPOS[@]}"; do
    echo -e "''${green}>>> [$IT/''${#REPOS[@]}] Cloning https://github.com$repo.git ...''${reset}"
    git clone "https://github.com$repo.git" "''${repo:1}"
    IT=$((IT + 1))
  done
''
