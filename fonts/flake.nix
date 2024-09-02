{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        defaultPackage = pkgs.symlinkJoin {
          name = "myfonts-0.1.0";
          paths = builtins.attrValues
            self.packages.${system}; # Add font derivation names here
        };

        packages.consolas-nerd-font = pkgs.stdenvNoCC.mkDerivation {
          name = "consolas-nerd-font";
          dontConfigue = true;
          src = pkgs.fetchzip {
            url =
              "https://www.dl.dropboxusercontent.com/scl/fi/vkn53srij8ni6md47vp9q/consolas-nerd-font.tar.gz?rlkey=v2c1zjnvgsajorli5ypu5nxp4&st=4mwzr0ox&dl=0";
            sha256 = "sha256-YO2fZy4h4ndetuEG6JUoWBem9CeDVMJdNwwVmgWJ1cE";
            stripRoot = false;
          };
          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/opentype/
          '';
          meta = { description = "Consolas but nerdy"; };
        };
      });
        
}
