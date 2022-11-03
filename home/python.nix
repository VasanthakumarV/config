{ pkgs, ... }: {
  home.packages = with pkgs; [ nodePackages.pyright pdm black ];
}
