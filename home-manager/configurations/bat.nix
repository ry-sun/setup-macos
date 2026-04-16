{ ... }:
{
  programs.bat = {
    enable = true;
    # extraPackages = with pkgs.bat-extras; [
    #   core
    #   batman
    #   batdiff
    #   batgrep
    #   batpipe
    #   batwatch
    #   prettybat
    # ];
    config = {
      theme = "TwoDark";
    };
  };
}
