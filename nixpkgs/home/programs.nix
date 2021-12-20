{ pkgs, ... }: {
  home.packages = with pkgs; [ exa bat ripgrep fd nixfmt bottom ];
}
