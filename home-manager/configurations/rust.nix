{ lib, ... }:
{
  home.sessionSearchVariables.CARGO_PATH = [ "$HOME/.cargo/bin" ];

  home.activation.initRust = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running init Rust step..." | tee -a ~/hm-activation.log

    export PATH="$HOME/.nix-profile/bin:$PATH"
    rustup install stable | tee -a ~/hm-activation.log
    rustup install nightly | tee -a ~/hm-avtivation.log

    rustup component add rustfmt --toolchain stable | tee -a ~/hm-activation.log
    rustup component add clippy --toolchain stable | tee -a ~/hm-activation.log
    rustup component add rust-analyzer --toolchain stable | tee -a ~/hm-activation.log

    rustup component add rustfmt --toolchain nightly | tee -a ~/hm-activation.log
    rustup component add clippy --toolchain nightly | tee -a ~/hm-activation.log
    rustup component add rust-analyzer --toolchain nightly | tee -a ~/hm-activation.log

    rustup update | tee -a ~/hm-activation.log

    rustup default stable | tee -a ~/hm-activation.log

    echo "Done init Rust" | tee -a ~/hm-activation.log
  '';
}
