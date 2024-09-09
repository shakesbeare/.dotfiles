{ config, pkgs, inputs, system, ... }:
{
    home.packages = [
        inputs.shake.packages.${system}.default
    ];
}
