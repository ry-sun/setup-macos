{ ... }:
{
  programs.ranger = {
    enable = true;
    extraConfig = builtins.unsafeDiscardStringContext (builtins.readFile ../dotfiles/ranger/rc.conf);
    plugins = [
      {
        name = "ranger_devicons";
        src = builtins.fetchGit {
          url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
          ref = "main";
        };
      }
    ];
  };

  home.file.".config/ranger/commands.py".source = ../dotfiles/ranger/commands.py;
  home.file.".config/ranger/scope.sh".source = ../dotfiles/ranger/scope.sh;
}
