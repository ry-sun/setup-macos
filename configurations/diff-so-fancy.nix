{ pkgs, ... }:
{
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
