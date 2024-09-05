{ config, pkgs, ... }:
{
    home.packages = [
        pkgs.neofetch
    ];

    programs.zsh.enable = true;
    programs.starship.enable = true;
    programs.zoxide.enable = true;
    programs.eza.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.htop.enable = true;
    programs.ripgrep.enable = true;

    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/zsh/.zshrc";
    };
}
