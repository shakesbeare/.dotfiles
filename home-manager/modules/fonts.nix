{ config, pkgs, inputs, system, ... }:
{
    home.packages = [
        inputs.shake-fonts.packages.${system}.default
    ];
}
