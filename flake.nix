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
    };

    outputs = { 
       nixpkgs, darwin, home-manager, ...
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
                            system = macos-system;
                         };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.bmoffett = import ./home-manager/macos-lt.nix;
                    }
                ];
            };
	};
    };
}
