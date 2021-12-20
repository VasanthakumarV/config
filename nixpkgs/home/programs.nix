{ pkgs, ... }: {
  home.packages = with pkgs; [ exa bat ripgrep fd bottom zellij nixfmt ];
}
