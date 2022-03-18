{ pkgs, user, ... }: {
  imports = [
    (import ./programs.nix { inherit pkgs; })
    (import ./zsh.nix { inherit pkgs; })
    (import ./rust.nix { inherit pkgs; })
    (import ./python.nix { inherit pkgs; })
    ./starship.nix
    ./alacritty.nix
    ./nvim
  ];
}
