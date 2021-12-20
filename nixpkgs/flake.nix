{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager }:
    let
      home = builtins.getEnv "HOME";
      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;

        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

        fonts = {
          enableFontDir = true;
          fonts = with pkgs;
            [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
        };

        users.users.vasanthakumarv = {
          name = "vasanthakumarv";
          home = "/Users/vasanthakumarv";
          shell = pkgs.zsh;
        };
      };
    in {
      darwinConfigurations."vasanthakumarv" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          configuration
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              users.vasanthakumarv = import "${home}/.config/nixpkgs/home";
            };
          }
        ];
      };
    };
}
