{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-eco
      gh-skyline
      gh-notify
      gh-copilot
      gh-dash
    ];
    settings = {
      editor = "nvim";
      git_protocol = "https";
    };
  };
}
