{ pkgs, self, args, ... }:
{
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.neovim
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Setup System
      system.primaryUser = args.user;
      nix.enable = false; # Currently, we are using determinated Nix.
      # nix.gc.automatic = true;
      # nix.optimise.automatic = true;
      nixpkgs.config.allowfree = true;

      # Install Softwares
      homebrew.brews = import ./install/brews.nix;
      homebrew.casks = ((import ./install/casks.nix) ++ (import ./install/fonts.nix));
      homebrew.masApps = import ./install/masApps.nix;

      imports = [
        ./settings/shell.nix
        ./settings/homebrew.nix
        ./settings/macos.nix
      ];
}
