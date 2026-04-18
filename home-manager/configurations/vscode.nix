{ lib, pkgs, config, ... }:
let
  vscodeUserDir = "${config.home.homeDirectory}/Library/Application Support/Code/User";
  vscodeExtensionsFile = builtins.toString ../dotfiles/vscode/extensions.txt;

  syncVscodeExtensions = pkgs.writeShellScriptBin "vscode-extension-sync" ''
    set -euo pipefail

    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

    code_bin="code"
    extensions_file="${vscodeExtensionsFile}"
    activation_log="$HOME/hm-activation.log"

    installed_extensions=$("$code_bin" --list-extensions)

    while IFS= read -r extension; do
      if [ -z "$extension" ]; then
        continue
      fi

      if ! echo "$installed_extensions" | grep -qF "$extension"; then
        "$code_bin" --install-extension "$extension" | tee -a "$activation_log"
      fi
    done < "$extensions_file"

    "$code_bin" --update-extensions | tee -a "$activation_log"
  '';
in
{
  # Settings file
  home.activation.vscodeMutableFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${vscodeUserDir}"

    rm -f "${vscodeUserDir}/settings.json"
    ln -sfn "${config.home.homeDirectory}/.config/home-manager/dotfiles/vscode/settings.jsonc" "${vscodeUserDir}/settings.json"
  '';

  # Keybindings file
  home.file."Library/Application Support/Code/User/keybindings.json".source =
    ../dotfiles/vscode/keybindings.jsonc;

  home.packages = [
    syncVscodeExtensions
  ];

  # Install extensions
  home.activation.installVscodeExtensions = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running install Vscode Extensions step..." | tee -a ~/hm-activation.log
    "${syncVscodeExtensions}/bin/vscode-extension-sync"
    echo "Done install Vscode Extensions step..." | tee -a ~/hm-activation.log
  '';
}
