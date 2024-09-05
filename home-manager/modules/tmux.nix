{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.tmux
    ];

    home.file = {
        ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/tmux/.tmux.conf";
    };
}
