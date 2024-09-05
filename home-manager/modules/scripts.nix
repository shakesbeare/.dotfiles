{ config, pkgs, ... }:
{
    home.file = {
        ".scripts".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/scripts";
    };
}
