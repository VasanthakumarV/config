{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.npm
    nodePackages.tailwindcss
    nodePackages.pyright
    black
    pdm
  ];
}
