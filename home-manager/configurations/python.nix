{ ... }:
{
  home.file.".condarc".source = ../dotfiles/.condarc;
  home.file.".mambarc".source = ../dotfiles/.condarc;
  home.file.".ipython/profile_default/ipython_config.py".source =
    ../dotfiles/ipython/ipython_config.py;
  home.file.".ipython/profile_default/startup/00-rich.py".source = ../dotfiles/ipython/00-rich.py;
}
