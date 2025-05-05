{ pkgs, args, ... }:
{
  ## Setup Brew auto-update
  homebrew.global.autoUpdate = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap"; # Make all home installation only can be managed by this file
    upgrade = true;
  };

  ## homebrew taps
  homebrew.taps = [
    {
      name = "homebrew/core";
      clone_target = "https://github.com/Homebrew/homebrew-core";
      force_auto_update = true;
    }
    {
      name = "homebrew/cask";
      clone_target = "https://github.com/Homebrew/homebrew-cask";
      force_auto_update = true;
    }
    {
      name = "homebrew/command-not-found";
      clone_target = "https://github.com/Homebrew/homebrew-command-not-found";
      force_auto_update = true;
    }
  ];
}
