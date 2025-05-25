{ pkgs, args, ... }:
{
  ##### Setup for nix and nix-darwin #####

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${args.arch}-darwin";

  ## Nix Options
  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  ##### Setup System #####
  homebrew.enable = true;
  homebrew.brews = import ../softwares/brews.nix;
  homebrew.casks = builtins.map (s: {
    name = s;
    greedy = true;
  }) ((import ../softwares/fonts.nix) ++ (import ../softwares/casks.nix));

  homebrew.masApps = import ../softwares/masApps.nix;

  imports = [
    ../system/shell.nix
    ../system/homebrew.nix
    ../system/macos.nix
  ];
}
