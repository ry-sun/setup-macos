{ pkgs, ... }:
{
  home.shellAliases = {
    ls = "eza --icons --octal-permissions --git --git-repos --header --group-directories-first";
    lsa = "ls -a";
    ll = "ls -a -l";
    lt = "ls -T";
    lta = "ls -T -a";
  };
}
