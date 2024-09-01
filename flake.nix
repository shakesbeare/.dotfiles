{
    description = "Home Manager Flake";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    };

    outputs = { 
       nixpkgs, home-manager, ...
    } @ inputs: {
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
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
