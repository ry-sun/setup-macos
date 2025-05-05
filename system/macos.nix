{ pkgs, args, ... }:
{
  # Setup Time zone
  time.timeZone = "Asia/Shanghai";

  ## hostname
  networking.hostName = args.hostname;
  networking.localHostName = args.hostname;

  ## Power settings
  power.sleep.allowSleepByPowerButton = true;
  power.sleep.computer = 60 * 8; # after 8h idel time, computer will sleep
  power.sleep.display = 60 * 6; # after 6h idel time, dispaly will sleep

  ## System settings
  system.defaults = {
    # Time and time zone
    NSGlobalDomain.AppleICUForce24HourTime = false; # use 12-hour time
    menuExtraClock.FlashDateSeparators = true; # flash colon in clock of menu bar
    menuExtraClock.Show24Hour = false; # use 12-hour time
    menuExtraClock.ShowAMPM = true; # use 12-hour time
    menuExtraClock.ShowDate = 0; # show Date
    menuExtraClock.ShowDayOfMonth = true;
    menuExtraClock.ShowDayOfWeek = true;
    menuExtraClock.ShowSeconds = true;

    # measureemtn and unit system
    NSGlobalDomain.AppleMeasurementUnits = "Centimeters"; # Use Centimeters as the measurement system
    NSGlobalDomain.AppleMetricUnits = 1; # Use metric system
    NSGlobalDomain.AppleTemperatureUnit = "Celsius"; # Use Celsius as temperature unit

    # Menu bar
    controlcenter.AirDrop = true; # Show AirDrop icon menu bar
    controlcenter.BatteryShowPercentage = true; # Show battery percentage in menu bar
    controlcenter.Bluetooth = false; # Do not show bluetooth icon in menu bar
    controlcenter.Display = false; # Do not show brightness control in menu bar
    controlcenter.FocusModes = true; # Show focus icon in menu bar
    controlcenter.NowPlaying = true; # Show now playing icon in menu bar
    controlcenter.Sound = false; # Do not show sound icon in menu bar

    # Finder
    NSGlobalDomain.AppleShowAllExtensions = true; # Show file extensions in Finder
    NSGlobalDomain.AppleShowAllFiles = false; # hide hidden file
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = false;
    finder.FXDefaultSearchScope = "SCcf"; # search current folder defaultly when searching in finder
    finder.FXEnableExtensionChangeWarning = false; # do not warn when changing the file extension
    finder.FXRemoveOldTrashItems = true; # automatically delete fileds in Trash after 30 days
    finder.NewWindowTarget = "Home";
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;

    # Dock
    dock.autohide = true; # Auto hide the dock
    dock.tilesize = 48; # dock size
    dock.largesize = 64; # dock icon size when hover
    dock.magnification = true; # magnify icon when hover
    dock.mineffect = "genie"; # use genie for minimize/maximize window effect
    dock.orientation = "bottom"; # dock should be placed in bottom
    dock.persistent-apps = [
      { app = "/System/Applications/Launchpad.app"; }
      { app = "/Applications/Safari.app"; }
      { app = "/System/Applications/Messages.app"; }
      { app = "/System/Applications/Mail.app"; }
      { app = "/System/Applications/FaceTime.app"; }
      { app = "/System/Applications/Calendar.app"; }
      { app = "/System/Applications/Reminders.app"; }
      { app = "/System/Applications/Notes.app"; }
      { app = "/System/Applications/Freeform.app"; }
      { app = "/System/Applications/Music.app"; }
      { app = "/Applications/Visual Studio Code.app"; }
      { app = "/Applications/Cursor.app"; }
      { app = "/Applications/iTerm.app"; }
      { app = "/System/Applications/iPhone Mirroring.app"; }
      { app = "/System/Applications/System Settings.app"; }
      { app = "/Applications/Loon.app"; }
    ];
    dock.persistent-others = [
      "${args.home}/Downloads"
      "${args.home}/Documents"
    ];
    dock.show-recents = true;
    dock.wvous-br-corner = 14; # Show quick note when hover bottom right cornor

    # Appearances
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true; # switch between light and dark automatically
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true; # Show full size save panel
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true; # SHow full size save panel

    # keyboard
    NSGlobalDomain."com.apple.keyboard.fnState" = true; # use F1-F12 without fn key
    hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

    # others
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true; # Automactically install system updates
    loginwindow.GuestEnabled = false;
    screencapture.target = "clipboard";
  };
}
