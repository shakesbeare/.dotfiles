{ config, pkgs, ... }:
{
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.neovim.enable = true;
    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/nvim_config";
    };
}
