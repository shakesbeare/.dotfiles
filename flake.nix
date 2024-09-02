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
        fonts.url = "git+file:///home/bmoffett/.dotfiles?dir=fonts";
    };

    outputs = { 
       nixpkgs, home-manager, ...
    } @ inputs: {
        nixosConfigurations = {
            nixos-dt = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
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
