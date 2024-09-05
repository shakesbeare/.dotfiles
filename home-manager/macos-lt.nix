{ config, pkgs, ... }:

{
    # DANGER ZONE {
        home.stateVersion = "24.05";
        programs.home-manager.enable = true;
    # } 

    imports = [
        ./modules/alacritty.nix
        ./modules/neovim.nix
        ./modules/zsh.nix
        ./modules/scripts.nix
        ./modules/git.nix
        ./modules/rofi.nix
        ./modules/cava.nix
        ./modules/tmux.nix
        ./modules/programming.nix
        ./modules/discord.nix
        ./modules/yabai.nix
    ];
}
