{ config, pkgs, ... }:
{
    programs.zsh.enable = true;
    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/zsh/.zshrc";
    };
}
