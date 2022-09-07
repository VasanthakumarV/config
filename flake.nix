{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
        username = "vasanth";
        home = "/Users/vasanth";
      };

      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;

        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

        fonts = {
          enableFontDir = true;
          fonts = with pkgs;
            [ (nerdfonts.override { fonts = [ "Hasklig" ]; }) ];
        };

        users.users.vasanth = {
          name = user.username;
          home = user.home;
          shell = pkgs.zsh;
        };
      };
    in {
      darwinConfigurations."vasanth" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          configuration
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              extraSpecialArgs = { user = user; };
              # TODO: Fix this, no hardcoding path
              users.vasanth = import "${home}/.config/config/home";
            };
          }
        ];
      };
    };
}
