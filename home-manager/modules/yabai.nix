{ config, pkgs, ... }:
{
    home.file = {
        ".yabairc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/yabai/.yabairc";
        ".skhdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/yabai/.skhdrc";
    };
}
