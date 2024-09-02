{ config, pkgs, ... }:

{
    home.stateVersion = "24.05";
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    home.packages = [
        pkgs.discord
        pkgs.bottles
        pkgs.maestral
    ];

    xsession.windowManager.i3 = {
        enable = true;
        config = {
            modifier = "Mod1";
            terminal = "alacritty";
        };
    };

    programs.neovim.enable = true;
    programs.zsh.enable = true;
    programs.git = {
        enable = true;
        userName = "Berint Moffett";
        userEmail = "berint.moffett@gmail.com";
    };
    programs.tmux = {
        enable = true;
        extraConfig = builtins.readFile ../tmux/.tmux.conf;
    };
    programs.zoxide.enable = true;
    programs.starship.enable = true;
    programs.firefox.enable = true;
    programs.eza.enable = true;
    programs.alacritty.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/zsh/.zshrc";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/nvim";
        ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/alacritty";
        ".scripts".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/scripts";
    };
}
