{ ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "yc";
  };

  home.file.".config/yazi/yazi.toml".source = ../dotfiles/yazi/settings.toml;
  home.file.".config/yazi/keymap.toml".source = ../dotfiles/yazi/keymap.toml;
}
