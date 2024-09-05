{ config, pkgs, ... }:
{
    home.file = {
        ".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/fonts";
    };
}
