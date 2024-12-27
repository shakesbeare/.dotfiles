{ config, pkgs, inputs, system, ... }:
{
    fonts.fontconfig.enable = true;

    # home.packages = [
    #     inputs.ghostty.packages.${system}.default
    # ];

    home.file = {
        ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ghostty/";
    };
}
