{ ... }:
{
  programs.clock-rs = {
    enable = true;
    settings = {
      general = {
        color = "magenta";
      };
      date = {
        use_12h = true;
      };
    };
  };
}
