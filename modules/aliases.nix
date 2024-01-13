{
  ls = "lsd --color=auto";
  la = "lsd -lAh --group-directories-first";
  lt = "lsd -lAh --group-directories-first --tree";
  llt = "unbuffer lsd -lAh --group-directories-first --tree | less -r";

  gg = "cd ~/code";
  gs = "git status";
  gl = "git log --oneline";
  glg = "git log --oneline --graph --decorate --all";
  gaa = "git add --all";
  gc = "git commit -m";
  gp = "git push";

  ta = "tmux attach";

  nec = "nvim --cmd \"cd $(readlink -f /etc/nixos)\"";
  ncc = "sudo nixos-rebuild switch --upgrade-all --flake \"$(readlink -f /etc/nixos)\"";
  nup = "sudo nix-channel --update";
  nuf = "sudo nix flake update --nix-path /etc/nixos";
  ngc = "sudo nix-collect-garbage -d";

  dcup = "docker-compose up --detach --remove-orphans";
  dka = "docker kill $(docker ps -q)";
  drmc = "docker container rm $(docker container ls -aq)";
  drmi = "docker image rm $(docker image ls -aq)";
  drmv = "docker volume rm $(docker volume ls -q)";

  lsip = "curl -s 'https://nordvpn.com/wp-admin/admin-ajax.php?action=get_user_info_data' | jq";
}
