{ config, pkgs, ... }:

{
    nixpkgs.config.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes"];
    imports = [
    ];
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages =
        [ 
                pkgs.vim
        ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.yabai.enable = true;
    services.yabai.enableScriptingAddition = true;
    services.skhd.enable = true;

    system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
    };

    system.defaults = {
    };

    # nix.package = pkgs.nix;

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;    # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

        users.users.bmoffett = {
                home = "/Users/bmoffett";
        };
        system.activationScripts.applications.text = pkgs.lib.mkForce (''
            echo "setting up ~/Applications/Nix..."
            rm -rf ~/Applications/Nix
            mkdir -p ~/Applications/Nix
            chown bmoffett ~/Applications/Nix
            find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
                src="$(/usr/bin/stat -f%Y $f)"
                appname="$(basename $src)"
                osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/bmoffett/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
            done
    '');
}
