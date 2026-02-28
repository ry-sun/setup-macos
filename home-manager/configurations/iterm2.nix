{ ... }:
{
  home.file.".config/iterm2/com.googlecode.iterm2.plist".source =
    ../dotfiles/iterm2/com.googlecode.iterm2.plist;

  home.file.".iterm2_shell_integration.zsh" = {
    source = ../dotfiles/iterm2/.iterm2_shell_integration.zsh;
    executable = true;
  };
}
