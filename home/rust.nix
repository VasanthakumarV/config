{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup
    rust-analyzer
    cargo-edit
    cargo-expand
    cargo-flamegraph
    probe-run
  ];
}
