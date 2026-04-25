{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      core

      # Thet are already included in `core`
      # batman
      # batdiff
      # batgrep
      # batpipe
      # batwatch
      # prettybat
    ];
    config = {
      theme = "TwoDark";
    };
  };
}
