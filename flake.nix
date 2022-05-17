{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager }:
    let
      home = builtins.getEnv "HOME";

      user = {
        username = "vasanthakumarv";
        home = "/Users/vasanthakumarv";
      };

      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;

        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

        fonts = {
          enableFontDir = true;
          fonts = with pkgs;
            [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
        };

        users.users.vasanthakumarv = {
          name = user.username;
          home = user.home;
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
              extraSpecialArgs = { user = user; };
              # TODO: Fix this, no hardcoding path
              users.vasanthakumarv = import "${home}/.config/config/home";
            };
          }
        ];
      };
    };
}
