{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.rustup
        (pkgs.python3.withPackages (ps: with ps; [ requests ]))
        pkgs.cmake
        pkgs.cargo-expand
        pkgs.nodejs
        pkgs.nixd
    ];

    home.file = {
        ".config/rustfmt/rustfmt.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/cargo/rustfmt.toml";
    };
}
