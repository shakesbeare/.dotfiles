{
    description = "Home Manager Flake";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
};

    outputs = { 
        self, nixpkgs, home-manager, ...
    } @ inputs: let 
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
        inherit (self) outputs;
    in {
	nixpkgs.hostPlatform = "x86_64-linux";
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [ ./nixos/configuration.nix];
            };
        };

        homeConfigurations = {
            "bmoffett@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
	    	pkgs = pkgs;
                extraSpecialArgs = {inherit inputs outputs;};
                configuration.imports = [ ./home-manager/home.nix ];
            };

        };
    };
}
