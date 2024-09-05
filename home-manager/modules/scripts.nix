{ config, pkgs, ... }:
{
    home.file = {
        ".scripts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/scripts";
    };
}
