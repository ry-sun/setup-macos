{ lib, ... }:
{
  home.file."Library/Application Support/Code/User/settings.json".source =
    ../dotfiles/vscode/settings.jsonc;
  home.file."Library/Application Support/Cursor/User/settings.json".source =
    ../dotfiles/vscode/settings.jsonc;

  home.file."Library/Application Support/Code/User/keybindings.json".source =
    ../dotfiles/vscode/keybindings.jsonc;
  home.file."Library/Application Support/Cursor/User/keybindings.json".source =
    ../dotfiles/vscode/keybindings.jsonc;

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

  home.activation.installCursorExtensions = lib.hm.dag.entryAfter [ "installVscodeExtensions" ] ''
    echo "Running install Cursor Extensions step..." | tee -a ~/hm-activation.log

    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

    installed_extensions=$(cursor --list-extensions)
    for extension in $(cat "${builtins.toString ../dotfiles/vscode/extensions.txt}"); do
      if ! echo "$installed_extensions" | grep -qF "$extension"; then
        (cursor --install-extension $extension | tee -a ~/hm-activation.log) || (echo "\033[31mInstall $extension failed\033[0m, may only can be used in VSCode" | tee -a ~/hm-activation.log)
      fi
    done

    cursor --update-extensions | tee -a ~/hm-activation.log

    echo "Done install Cursor Extensions step..." | tee -a ~/hm-activation.log
  '';
}
