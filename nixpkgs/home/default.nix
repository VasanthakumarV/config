{ pkgs, ... }: {
  imports = [
    (import ./programs.nix { inherit pkgs; })
    (import ./zsh.nix { inherit pkgs; })
    ./starship.nix
    ./alacritty.nix
    ./nvim
  ];
}
