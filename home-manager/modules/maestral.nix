{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.maestral
    ];
}
