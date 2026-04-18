{ lib, config, ... }:
{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
  };

  home.activation.CodexConfigLink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.codex"

    rm -f "${config.home.homeDirectory}/.codex/config.toml"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/codex/config.toml" "${config.home.homeDirectory}/.codex/config.toml"
  '';

}
