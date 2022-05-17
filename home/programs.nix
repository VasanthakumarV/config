{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    bat
    ripgrep
    fd
    bottom
    dua
    nixfmt
    nushell

    # Required for downloading and parsing chip files
    # Associated with Embassy
    jq
    wget
    svdtools

    # Podman and dependencies
    podman
    qemu
    xz
    podman-compose
  ];
}
