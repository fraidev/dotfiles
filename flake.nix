{
  description = "felipe dotfiles — cross-platform via home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Expert: unified Elixir language server (not yet in nixpkgs).
    expert.url = "github:expert-lsp/expert";
  };

  outputs = { self, nixpkgs, home-manager, expert, ... }:
    let
      username = "frai";

      mkHome = { system, extraModules, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit expert system; };
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
