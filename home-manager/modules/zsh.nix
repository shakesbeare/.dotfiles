{ config, pkgs, ... }:
{
    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/zsh/.zshrc";
    };
}
