{ lib, config, ... }:
let
  vscodeUserDir = "${config.home.homeDirectory}/Library/Application Support/Code/User";
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

  # Install extensions
  home.activation.installVscodeExtensions = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running install Vscode Extensions step..." | tee -a ~/hm-activation.log

    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

    installed_extensions=$(code --list-extensions)
    for extension in $(cat "${builtins.toString ../dotfiles/vscode/extensions.txt}"); do
      if ! echo "$installed_extensions" | grep -qF "$extension"; then
        code --install-extension $extension | tee -a ~/hm-activation.log
      fi
    done

    code --update-extensions | tee -a ~/hm-activation.log

    echo "Done install Vscode Extensions step..." | tee -a ~/hm-activation.log
  '';
}
