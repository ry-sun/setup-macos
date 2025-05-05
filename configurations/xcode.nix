{ pkgs, ... }:
{
  home.activation.initXcode = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running init Xcode step..." | tee -a ~/hm-activation.log

    export PATH="$PATH:/usr/bin"
    sudo xcodebuild -license accept
    sudo xcode-select -s /Applications/Xcode.app/Contents/Developer/

    echo "Done init Xcode" | tee -a ~/hm-activation.log
  '';
}
