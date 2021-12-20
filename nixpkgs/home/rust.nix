{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup
    rust-analyzer
    cargo-expand
    cargo-flamegraph
  ];
}
