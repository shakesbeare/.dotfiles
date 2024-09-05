{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.waybar
    ];

    programs.feh.enable = true;

    home.file = {
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/hypr";
        ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/waybar";
    };
}
