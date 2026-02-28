{ pkgs, args, ... }:
{
  ## Register Shell in /etc/shell
  environment.shells = [
    pkgs.zsh
    pkgs.bash
  ];

  users.users."${args.user}".shell = pkgs.zsh;

  ## Setup system level bash
  programs.bash.enable = true;
  programs.bash.completion.enable = true;

  ## Setup system level zsh
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableFastSyntaxHighlighting = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;
  programs.zsh.enableGlobalCompInit = true;
  programs.zsh.enableSyntaxHighlighting = false;
}
