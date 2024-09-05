{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.grim
        pkgs.slurp
        pkgs.swappy
    ];
}
