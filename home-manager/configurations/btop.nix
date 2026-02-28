{ ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_tree = true;
    };
  };
}
