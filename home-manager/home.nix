{
  lib,
  config,
  pkgs,
  args,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = args.user;
  home.homeDirectory = args.home;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = (import ../softwares/nixPackages.nix) pkgs;

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../configurations/bash.nix
    ../configurations/bat.nix
    ../configurations/btop.nix
    ../configurations/c.nix
    ../configurations/clcokRs.nix
    ../configurations/diff-so-fancy.nix
    ../configurations/editorconfig.nix
    ../configurations/eza.nix
    ../configurations/fzf.nix
    ../configurations/gh.nix
    ../configurations/git.nix
    ../configurations/iterm2.nix
    ../configurations/lazygit.nix
    ../configurations/node.nix
    ../configurations/ohMyPosh.nix
    ../configurations/pay-respects.nix
    ../configurations/python.nix
    ../configurations/ranger.nix
    ../configurations/rust.nix
    ../configurations/ssh.nix
    ../configurations/vscode.nix
    ../configurations/zsh.nix
  ];

  home.sessionVariables = {
    # Color settings
    TERM = "xterm-256color";
    LESS = "-R -M -i -j5";
    CLICOLOR = "1";
    LSCOLORS = "GxFxCxDxBxegedabagaced";

    # Locale settings
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    TZ = "Asia/Shanghai";

    # Editor
    EDITOR = "nvim";
  };
  home.sessionPath = [
    "$BUN_PATH"
    "$CARGO_PATH"
    "$HOME/.local/bin"
  ];
}
