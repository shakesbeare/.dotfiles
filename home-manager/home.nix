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
        pkgs.neofetch
        pkgs.autorandr
        pkgs.rustup
        (pkgs.python3.withPackages (ps: with ps; [ requests ]))
        pkgs.waybar
        pkgs.rofi-wayland
        pkgs.tmux
    ];

    home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 48;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/ful1e5/XCursor-pro/releases/download/v2.0.2/XCursor-Pro-Dark.tar.xz"
        "sha256-x1rmWRGPXshOgcxTUXbhWTQHAO/BT6XVfE8SVLNFMk4="
        "XCursor-Pro-Dark";

    xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
            modifier = "Mod1";
            defaultWorkspace = "workspace number 1";
            terminal = "alacritty";
            bars = [];
            gaps = {
                inner = 10;
                outer = 0;
            };
            floating.border = 0;
            window = {
                border = 0;
                hideEdgeBorders = "both";
                titlebar = false;
            };
            startup = [
                { command = "autotiling -w 1 3 5 7 9"; always = true; notification = false; }
                { command = "polybar -c /home/bmoffett/.dotfiles/polybar/config.ini"; always = true; notification = false; }
            ];
        };
    };

    services.autorandr.enable = true;
    services.flameshot.enable = true;

    programs.neovim.enable = true;
    programs.zsh.enable = true;
    programs.git = {
        enable = true;
        userName = "Berint Moffett";
        userEmail = "berint.moffett@gmail.com";
    };
    programs.zoxide.enable = true;
    programs.starship.enable = true;
    programs.firefox.enable = true;
    programs.eza.enable = true;
    programs.alacritty.enable = true;
    programs.fzf.enable = true;
    programs.bat.enable = true;
    programs.feh.enable = true;
    programs.htop.enable = true;
    programs.ripgrep.enable = true;
    programs.cava = {
        enable = true;
        settings.input.method = "pipewire";
    };
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = "./.dotfiles/themes/rofi/spotlight_dark.rasi";
    };
    programs.hyprlock = {
        enable = true;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/zsh/.zshrc";
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/nvim";
        ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/alacritty";
        ".scripts".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/scripts";
        ".config/autorandr".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/autorandr";
        ".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/fonts";
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/hypr";
        ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/waybar";
        ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/bmoffett/.dotfiles/tmux/.tmux.conf";
    };
}
