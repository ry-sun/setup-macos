{ ... }:
{
    homebrew = {
        enable = true;

        # Setup Shell Integration
        enableBashIntegration = true;
        enableZshIntegration = true;

        # Setup Brew auto-update
        global.autoUpdate = true;
        global.brewfile = true;
        greedyCasks = true;
        onActivation.autoUpdate = true;
        onActivation.cleanup = "zap"; # Make all home installation only can be managed by this file
        onActivation.upgrade = true;
      };
  }
