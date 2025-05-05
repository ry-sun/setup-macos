{ pkgs, lib, ... }:
{
  home.sessionVariables.NVM_DIR = "$\{HOME\}/.nvm";
  home.sessionSearchVariables.BUN_PATH = [ "$HOME/.bun/bin" ];

  home.activation.installLtsNode = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running installLtsNode step..." | tee -a ~/hm-activation.log

    export NVM_DIR="$HOME/.nvm"
    export PATH="$PATH:/usr/bin"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

    nvm install --lts --latest-npm --save | tee -a ~/hm-activation.log
    echo "Done installing node" | tee -a ~/hm-activation.log
  '';
}
