{ pkgs, ... }: {
  home.packages = with pkgs; [ nodePackages.pyright poetry black ];
}
