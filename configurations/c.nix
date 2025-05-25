{ pkgs, args, ... }:
{
  home.sessionSearchVariables.C_INCLUDE_PATH = [ "$HOME/.local/include" ];
  home.sessionSearchVariables.CPLUS_INCLUDE_PATH = [ "$HOME/.local/include" ];
  home.sessionSearchVariables.LIBRARY_PATH = [
    "$HOME/.local/lib"
    "$HOME/.local/lib64"
    "${pkgs.darwin.libiconv}/lib"
  ];
  home.sessionSearchVariables.DYLD_LIBRARY_PATH = [
    "$HOME/.local/lib"
    "$HOME/.local/lib64"
    "${pkgs.darwin.libiconv}/lib"
  ];
  home.sessionVariables = {
    CC = "gcc";
    CXX = "g++";
    LDFLAGS = "-L${pkgs.darwin.libiconv}/lib";
    CPPFLAGS = "-I${pkgs.darwin.libiconv}/include";
  };
}
