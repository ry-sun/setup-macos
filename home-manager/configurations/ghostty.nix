{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    package = null;
    clearDefaultKeybinds = false;
    settings = {
      # Basic Settings
      language = "en";
      font-size = 14;
      font-thicken = true;
      font-thicken-strength = 128;
      font-shaping-break = "cursor";

      # Theme
      theme = "light:Xcode WWDC,dark:Xcode Dark hc";
      background-opacity = 0.7;
      background-opacity-cells = true;
      background-blur = "macos-glass-regular";

      # Selection
      selection-clear-on-typing = false;
      selection-clear-on-copy = false;

      # Cursor
      adjust-cursor-thickness = "80%";
      cursor-opacity = 1;
      cursor-style = "bar";
      cursor-style-blink = true;
      cursor-click-to-move = true;

      # Mouse
      mouse-hide-while-typing = true;
      mouse-reporting = true;

      # Notification
      notify-on-command-finish = "always";

      # Scroll Bar
      scrollbar = "system";

      # Link
      link-url = true;
      link-previews = true;

      # Window
      window-padding-x = 3;
      window-padding-y = 3;
      window-vsync = true;

      window-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;
      window-inherit-font-size = true;
      window-subtitle = "working-directory";
      window-colorspace = "display-p3";
      window-height = 60;
      window-width = 210;
      window-save-state = "always";
      window-new-tab-position = "end";
      window-show-tab-bar = "always";

      # Cliphboard
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      clipboard-paste-protection = true;

      quit-after-last-window-closed = false;
      initial-window = true;

      # Shell
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,ssh-env,ssh-terminfo,path";

      # Macos
      macos-window-buttons = "visible";
      macos-titlebar-style = "tabs";
      macos-dock-drop-behavior = "new-tab";
      macos-option-as-alt = true;
      macos-window-shadow = true;
      macos-hidden = "never";
      macos-auto-secure-input = true;
      macos-secure-input-indication = false;
      macos-applescript = true;
      macos-shortcuts = "allow";

      desktop-notifications = true;
      progress-style = true;

      auto-update = "check";
    };
  };
}
