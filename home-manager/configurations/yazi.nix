{
  lib,
  pkgs,
  config,
  ...
}:
let
  yaziConfigDir = "${config.home.homeDirectory}/.config/yazi";
  yaziPluginsDir = "${yaziConfigDir}/plugins";

  yaziPkgPlugins = [
    "yazi-rs/plugins:full-border"
    "yazi-rs/plugins:git"
    "yazi-rs/plugins:mount"
    "yazi-rs/plugins:piper"
    "yazi-rs/plugins:zoom"
    "yazi-rs/plugins:chmod"
    "yazi-rs/plugins:diff"
    "yazi-rs/plugins:toggle-pane"
    "AnirudhG07/rich-preview"
    "walldmtd/blender-preview"
    "Shallow-Seek/djvu-view"
    "Sonico98/exifaudio"
    "ruudjhuu/f3d-preview"
    "tasnimAlam/rotate-image"
    "AminurAlam/yazi-plugins:preview-typst"
    "wylie102/duckdb"
    "KKV9/compress"
    "atareao/convert"
    "lmnek/pandoc"
    "uhs-robert/recycle-bin"
    "boydaihungst/restore"
    "GianniBYoung/rsync"
    "walldmtd/fs-usage"
    "Lil-Dank/lazygit"
    "AnirudhG07/plugins-yazi:copy-file-contents"
    "boydaihungst/save-clipboard-to-file"
  ];

  yaziManualPlugins = [
    {
      repo = "https://github.com/saumyajyoti/omp.yazi.git";
      dir = "omp.yazi";
    }
    {
      repo = "https://github.com/grimandgreedy/ffmpeg-stats.yazi.git";
      dir = "ffmpeg-stats.yazi";
    }
  ];

  syncYaziPlugins = pkgs.writeShellScriptBin "yazi-plugin-sync" ''
    set -euo pipefail

    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

    ya_bin="${pkgs.yazi}/bin/ya"
    git_bin="${pkgs.git}/bin/git"
    config_dir="${yaziConfigDir}"
    plugins_dir="${yaziPluginsDir}"
    activation_log="$HOME/hm-activation.log"

    wanted_plugins=(
    ${lib.concatMapStringsSep "\n" (plugin: "  ${lib.escapeShellArg plugin}") yaziPkgPlugins}
    )

    manual_plugins=(
    ${lib.concatMapStringsSep "\n" (
      plugin: "  ${lib.escapeShellArg "${plugin.repo}|${plugin.dir}"}"
    ) yaziManualPlugins}
    )

    contains() {
      local needle="$1"
      shift || true
      local item
      for item in "$@"; do
        if [ "$item" = "$needle" ]; then
          return 0
        fi
      done
      return 1
    }

    read_installed_plugins() {
      "$ya_bin" pkg list | sed -nE 's/^[[:space:]]+([^[:space:]]+)[[:space:]]+\(.+\)$/\1/p'
    }

    mkdir -p "$config_dir" "$plugins_dir"

    "$ya_bin" pkg upgrade | tee -a "$activation_log"

    current_plugins=()
    while IFS= read -r plugin; do
      current_plugins+=("$plugin")
    done < <(read_installed_plugins)

    for plugin in "''${wanted_plugins[@]}"; do
      if ! contains "$plugin" "''${current_plugins[@]}"; then
        "$ya_bin" pkg add "$plugin" | tee -a "$activation_log"
      fi
    done

    for spec in "''${manual_plugins[@]}"; do
      repo="''${spec%%|*}"
      dir="''${spec#*|}"
      target="$plugins_dir/$dir"

      if [ -d "$target/.git" ]; then
        continue
      fi

      if [ -e "$target" ]; then
        echo "Skipping manual Yazi plugin $dir because $target exists and is not a git repository" | tee -a "$activation_log"
        continue
      fi

      "$git_bin" clone "$repo" "$target" | tee -a "$activation_log"
    done
  '';

in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "yc";

    initLua = ../dotfiles/yazi/init.lua;
  };

  home.packages = [
    syncYaziPlugins
  ];

  home.activation.installYaziPlugins = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running installYaziPlugins step..." | tee -a ~/hm-activation.log
    "${syncYaziPlugins}/bin/yazi-plugin-sync"
    echo "Done installYaziPlugins step..." | tee -a ~/hm-activation.log
  '';

  home.file.".config/yazi/yazi.toml".source = ../dotfiles/yazi/settings.toml;
  home.file.".config/yazi/keymap.toml".source = ../dotfiles/yazi/keymap.toml;
}
