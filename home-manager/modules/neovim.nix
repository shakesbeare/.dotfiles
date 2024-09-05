{ config, pkgs, ... }:
{
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.neovim.enable = true;
    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim_config";
    };
}
