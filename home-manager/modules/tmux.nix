{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.tmux
    ];

    home.file = {
        ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/tmux/.tmux.conf";
    };
}
