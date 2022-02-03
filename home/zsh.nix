{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = { ls = "exa"; };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = [ "defer:2" ];
        }
      ];
    };
  };
}
