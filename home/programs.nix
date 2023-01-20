{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fd
    bottom
    nixfmt
    nushell
    wezterm

    # Required for downloading and parsing chip files
    # Associated with Embassy
    jq
    wget
    svdtools

    # Rust linker
    zld

    # For tauri-android
    jdk
  ];
}
