{ lib, config, ... }:
{
  programs.zed-editor = {
    enable = true;
    enableMcpIntegration = true;
    package = null;
  };
  home.activation.ZedConfigurations = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.config/zed"

    rm -f "${config.home.homeDirectory}/.config/zed/settings.json"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/zed/settings.jsonc" "${config.home.homeDirectory}/.config/zed/settings.json"

    rm -f "${config.home.homeDirectory}/.config/zed/keymap.json"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/zed/keymap.jsonc" "${config.home.homeDirectory}/.config/zed/keymap.json"

    rm -f "${config.home.homeDirectory}/.config/zed/tasks.json"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/zed/tasks.jsonc" "${config.home.homeDirectory}/.config/zed/tasks.json"

    rm -f "${config.home.homeDirectory}/.config/zed/debug.json"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/zed/debug.jsonc" "${config.home.homeDirectory}/.config/zed/debug.json"
  '';
}
