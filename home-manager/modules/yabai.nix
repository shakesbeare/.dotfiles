{ config, pkgs, ... }:
{
    home.pkgs [
        pkgs.yaba
        pkgs.skhd
    ];

    home.file = {
        ".yabairc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/yabai/.yabairc";
        ".skhdrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/yabai/.skhdrc";
    };
}
