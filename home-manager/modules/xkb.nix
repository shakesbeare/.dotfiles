{ config, pkgs, ... }:
{
    home.file = {
        ".config/xkb/symbols/real-prog-dvorak".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/keyboard/real-prog-dvorak";
    };
}
