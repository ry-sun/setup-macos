{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
      };
      git = {
        skipHookPrefix = "wip";
        parseEmoji = true;
      };
      os = {
        editPreset = "nvim";
      };
    };
  };
}
