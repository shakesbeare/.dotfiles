{ config, pkgs, ... }:

{
    # DANGER ZONE {
        home.stateVersion = "24.05";
        programs.home-manager.enable = true;
    # } 

    home.sessionVariables = {
        SYSTEM = "x86_64-linux";
    };

    programs.wezterm = {
        enable = true;
    };


    imports = [
        ./modules/btop.nix
        ./modules/alacritty.nix
        ./modules/neovim.nix
        ./modules/zsh.nix
        ./modules/scripts.nix
        ./modules/fonts.nix
        ./modules/git.nix
        ./modules/rofi.nix
        ./modules/cava.nix
        ./modules/hypr.nix
        ./modules/tmux.nix
        ./modules/xkb.nix
        ./modules/cursor.nix
        ./modules/screenshot.nix
        ./modules/programming.nix
        ./modules/discord.nix
        ./modules/maestral.nix
        ./modules/obs-studio.nix
        ./modules/shake.nix
    ];

    programs.firefox.enable = true;
}
