{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.neofetch
    ];

    programs.zsh.enable = true;
    programs.starship.enable = true;
    programs.firefox.enable = true;
    programs.zoxide.enable = true;
    programs.eza.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.htop.enable = true;
    programs.ripgrep.enable = true;

    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/zsh/.zshrc";
    };
}
