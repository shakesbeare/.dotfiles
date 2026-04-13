{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shake = {
      url = "github:shakesbeare/shake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shake-fonts = {
      url = "git+ssh://git@github.com/shakesbeare/fonts?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pico8-bin = {
      url = "git+ssh://git@github.com/shakesbeare/pico8-bin?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
    macos-system = "aarch64-darwin";
    linux-system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos-dt = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
        };
        system = linux-system;
        modules = [
          ./nixos/nixos-dt.nix
          {
            nixpkgs.overlays = overlays;
          }
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          home-manager.nixosModules.home-manager
          {
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
      macos-lt = darwin.lib.darwinSystem rec {
        system = macos-system;
        modules = [
          ./nixos/macos-lt.nix
          {
            # this is fixed but alejandra doesn't seem to have released the fix yet https://github.com/kamadorueda/alejandra/issues/470#event-21387668433
            # environment.systemPackages = [alejandra.defaultPackage.${system}];
            environment.systemPackages = [alejandra.packages.aarch64-darwin.alejandra-arm64-apple-darwin]; # this can be deleted once above fixed
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
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
