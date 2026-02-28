{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-eco
      gh-skyline
      gh-notify
      gh-dash
      github-copilot-cli
    ];
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
    };
  };
}
