{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup
    rust-analyzer
    cargo-edit
    cargo-expand
    cargo-flamegraph
    cargo-watch
    probe-run
	sqlx-cli
  ];
}
