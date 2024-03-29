{ pkgs, home, ... }: {
  home.stateVersion = "22.11";

  imports = [
    (import ./programs.nix { inherit pkgs; })
    (import ./zsh.nix { inherit pkgs; })
    (import ./rust.nix { inherit pkgs; })
    (import ./python.nix { inherit pkgs; })
    ./starship.nix
  ];
}
