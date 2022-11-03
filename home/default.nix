{ pkgs, home, ... }: {
  home.stateVersion = "22.05";

  android-sdk.enable = true;
  # Optional; default path is "~/.local/share/android".
  android-sdk.path = "${home}/.android/sdk";
  android-sdk.packages = sdk:
    with sdk; [
      build-tools-31-0-0
      cmdline-tools-latest
      emulator
      platforms-android-31
      sources-android-31
    ];

  imports = [
    (import ./programs.nix { inherit pkgs; })
    (import ./zsh.nix { inherit pkgs; })
    (import ./rust.nix { inherit pkgs; })
    (import ./python.nix { inherit pkgs; })
    ./starship.nix
    ./alacritty.nix
    ./zellij.nix
    ./nvim
  ];
}
