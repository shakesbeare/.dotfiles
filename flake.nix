{
    description = "Home Manager Flake";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };
        nixpkgs-master = {
            url = "github:nixos/nixpkgs/master";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { 
       nixpkgs, home-manager, ...
    } @ inputs: let
        master-pkgs = inputs.nixpkgs-master.legacyPackages."x86_64-linux";
    in {
        nixosConfigurations = {
            nixos-dt = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; inherit master-pkgs; };
                system = "x86_64-linux";
                modules = [
                    ./nixos/configuration.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.bmoffett = import ./home-manager/home.nix;
                    }
                ];
            };
        };
    };
}
