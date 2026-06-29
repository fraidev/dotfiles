{
  description = "felipe dotfiles — cross-platform via home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      username = "frai";

      mkHome = { system, extraModules, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./nix/home.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ] ++ extraModules;
        };
    in {
      homeConfigurations = {
        "frai-mac" = mkHome {
          system = "aarch64-darwin";
          homeDirectory = "/Users/${username}";
          extraModules = [ ./nix/darwin.nix ];
        };

        "frai-linux" = mkHome {
          system = "x86_64-linux";
          homeDirectory = "/home/${username}";
          extraModules = [ ./nix/linux.nix ];
        };
      };
    };
}
