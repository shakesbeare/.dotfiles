# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
    inputs,
    lib,
    config,

    pkgs,
    ...
}: {
    imports = [
    	inputs.nixos-wsl.nixosModules.default
    ];
    wsl.enable = true;
    wsl.defaultUser = "bmoffett";

    environment.systemPackages = [ pkgs.zsh pkgs.neovim pkgs.git ];
    programs.zsh.enable = true;

    nixpkgs = {
        overlays = [
        ];
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
        };
    };

    nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
        settings = {
            experimental-features = "nix-command flakes";
            flake-registry = "";
            nix-path = config.nix.nixPath;

        };
        channel.enable = false;

        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    networking.hostName = "nixos";

    users.users = {

        bmoffett = {
            shell = pkgs.zsh;
            isNormalUser = true;
            extraGroups = ["wheel"];
        };
    };

    # This setups a SSH server. Very important if you're setting up a headless system.
    # Feel free to remove if you don't need it.
    services.openssh = {
        enable = true;
        settings = {
            # Opinionated: forbid root login through SSH.

            PermitRootLogin = "no";
            # Opinionated: use keys only.
            # Remove if you want to SSH using passwords
            PasswordAuthentication = false;
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.05";
}
