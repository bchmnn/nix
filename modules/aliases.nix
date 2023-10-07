{
  ls = "lsd --color=auto";
  la = "lsd -lAh --group-directories-first";
  lt = "lsd -lAh --group-directories-first --tree";
  llt = "unbuffer lsd -lAh --group-directories-first --tree | less -r";
  gg = "cd ~/git";
  gs = "git status";
  gl = "git log --oneline";
  glg = "git log --oneline --graph --decorate --all";
  gaa = "git add --all";
  gc = "git commit -m";
  gp = "git push";
  ta = "tmux attach";
  ngc = "sudo nix-collect-garbage -d";
  nec = "sudo -E nvim -u $HOME/.config/nvim/init.lua --cmd 'cd /etc/nixos'";
  ncc = "sudo nixos-rebuild switch --upgrade-all --flake /etc/nixos";
  nup = "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade-all --flake /etc/nixos";
}
