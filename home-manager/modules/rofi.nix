{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.rofi-wayland
    ];
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = "./.dotfiles/themes/rofi/spotlight_dark.rasi";
    };
}

