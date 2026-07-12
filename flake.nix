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

      # lima from nixpkgs fails to link on macOS 26 (cctools ld crash on
      # Virtualization.framework) and is not cached for aarch64-darwin.
      # Use the official prebuilt binary instead.
      limaOverlay = final: prev: {
        lima = final.callPackage ./nix/packages/lima-bin.nix { };
      };

      mkHome = { system, extraModules, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ limaOverlay ];
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
