{ config, pkgs, ... }:
{
    home.file = {
        ".config/xkb/symbols/true-prog-qwerty".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/true-programmers-qwerty/Linux/true-prog-qwerty";
    };
}
