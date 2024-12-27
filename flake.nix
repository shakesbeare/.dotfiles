{
    description = "Home Manager Flake";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };

        nixpkgs-master = {
            url = "github:nixos/nixpkgs/master";
        };
        
        darwin = {
            url = "github:lnl7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };


        shake = {
            url = "github:shakesbeare/shake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        shake-fonts = {
            url = "git+ssh://git@github.com/shakesbeare/fonts?ref=main";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { 
       nixpkgs, darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ...
    } @ inputs: let
        master-pkgs = inputs.nixpkgs-master.legacyPackages."x86_64-linux";
        macos-system = "aarch64-darwin";
        linux-system = "x86_64-linux";
    in {
        nixosConfigurations = {
            nixos-dt = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; inherit master-pkgs; };
                system = linux-system;
                modules = [
                    ./nixos/nixos-dt.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                            system = linux-system;
                        };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.bmoffett = import ./home-manager/nixos-dt.nix;
                    }
                ];
            };
        };
	darwinConfigurations = {
        macos-lt = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                modules = [
                    ./nixos/macos-lt.nix
                    home-manager.darwinModules.home-manager {
                        home-manager.extraSpecialArgs = { 
                            inherit inputs;
                            system = macos-system;
                         };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.bmoffett = import ./home-manager/macos-lt.nix;
                    }
                    nix-homebrew.darwinModules.nix-homebrew
                    {
                      nix-homebrew = {
                        # Install Homebrew under the default prefix
                        enable = true;

                        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                        enableRosetta = true;

                        # User owning the Homebrew prefix
                        user = "bmoffett";

                        # Optional: Declarative tap management
                        taps = {
                          "homebrew/homebrew-core" = homebrew-core;
                          "homebrew/homebrew-cask" = homebrew-cask;
                          "homebrew/homebrew-bundle" = homebrew-bundle;
                        };

                        # Optional: Enable fully-declarative tap management
                        #
                        # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
                        mutableTaps = true;
                      };
                    }
                ];
            };
	};
    };
}
