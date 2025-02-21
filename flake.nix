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

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    shake = {
      url = "github:shakesbeare/shake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    shake-fonts = {
      url = "git+ssh://git@github.com/shakesbeare/fonts?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pico8-bin = {
      url = "git+ssh://git@github.com/shakesbeare/pico8-bin?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

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
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    master-pkgs = inputs.nixpkgs-master.legacyPackages."x86_64-linux";
    macos-system = "aarch64-darwin";
    linux-system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos-dt = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          inherit master-pkgs;
        };
        system = linux-system;
        modules = [
          ./nixos/nixos-dt.nix
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
            environment.systemPackages = [alejandra.defaultPackage.${system}];
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
