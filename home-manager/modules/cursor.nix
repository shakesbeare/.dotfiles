{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.adwaita-icon-theme
    ];

    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
    };
}
