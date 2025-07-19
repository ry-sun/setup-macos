{ pkgs, lib, ... }:
{
  home.sessionSearchVariables.CARGO_PATH = [ "$HOME/.cargo/bin" ];

  home.activation.initRust = lib.hm.dag.entryAfter [ "installPackages" ] ''
    echo "Running init Rust step..." | tee -a ~/hm-activation.log

    export PATH="$HOME/.nix-profile/bin:$PATH"
    rustup install stable | tee -a ~/hm-activation.log
    rustup default stable | tee -a ~/hm-activation.log
    rustup component add rustfmt | tee -a ~/hm-activation.log
    rustup component add clippy | tee -a ~/hm-activation.log
    rustup component add rust-analyzer | tee -a ~/hm-activation.log

    echo "Done init Rust" | tee -a ~/hm-activation.log
  '';
}
