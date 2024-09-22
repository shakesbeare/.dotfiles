{ config, pkgs, inputs, system, ... }:
{
    fonts.fontconfig.enable = true;

    home.packages = [
        inputs.shake-fonts.packages.${system}.default
    ];
}
