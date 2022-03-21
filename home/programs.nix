{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    bat
    ripgrep
    fd
    bottom
    dua
    zellij
    nixfmt

    # Required for downloading and parsing chip files
    # Associated with Embassy
    jq
    wget
    svdtools

	# Podman and its dependencies
    podman
    qemu
    xz
  ];
}
