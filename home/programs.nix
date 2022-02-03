{ pkgs, ... }: {
  home.packages = with pkgs; [
    exa
    bat
    ripgrep
    fd
    bottom
    zellij
    nixfmt

    # Python related
    pipenv
    black

    # Required for downloading and parsing chip files
    # Associated with Embassy
    jq
    wget
    svdtools
  ];
}
