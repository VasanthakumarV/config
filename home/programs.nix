{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    bat
    ripgrep
    fd
    bottom
    zellij
    nixfmt

    # Required for downloading and parsing chip files
    # Associated with Embassy
    jq
    wget
    svdtools
  ];
}
