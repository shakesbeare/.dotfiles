{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.rustup
        (pkgs.python3.withPackages (ps: with ps; [ requests ]))
        pkgs.cmake
        pkgs.cargo-expand
    ];
}
