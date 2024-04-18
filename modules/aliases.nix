{
  
  ls = "eza --group-directories-first --hyperlink --icons";
  la = "eza --group-directories-first --hyperlink --icons -la";
  lt = "eza --group-directories-first --hyperlink --icons -la --tree";
  llt = "unbuffer eza --group-directories-first --hyperlink --icons -la --tree | less -r";
  # ls = "lsd --color=auto --hyperlink=auto";
  # la = "lsd -lAh --group-directories-first --hyperlink=auto";
  # lt = "lsd -lAh --group-directories-first --tree --hyperlink=auto";
  # llt = "unbuffer lsd -lAh --group-directories-first --tree --hyperlink=auto | less -r";

  gg = "cd ~/code";
  # gs = "git status";
  gl = "git log --oneline";
  glg = "git log --oneline --graph --decorate --all";
  gaa = "git add --all";
  gc = "git commit -m";
  gp = "git push";

  ta = "tmux attach";

  nec = "nvim --cmd \"cd $(readlink -f /etc/nixos)\"";
  ncc = "sudo nixos-rebuild switch --upgrade-all --flake \"$(readlink -f /etc/nixos)\"";
  nup = "sudo nix-channel --update";
  ngc = "sudo nix-collect-garbage -d";

  dcup = "docker-compose up --detach --remove-orphans";
  dka = "docker kill $(docker ps -q)";
  drmc = "docker container rm $(docker container ls -aq)";
  drmi = "docker image rm $(docker image ls -aq)";
  drmv = "docker volume rm $(docker volume ls -q)";

  lsip = "curl -s 'https://nordvpn.com/wp-admin/admin-ajax.php?action=get_user_info_data' | jq";

  xo = "xdg-open";
}
