{ pkgs, ... }:
{
  home.file.".config/iterm2/com.googlecode.iterm2.plist".source =
    ../dotfiles/com.googlecode.iterm2.plist;
}
