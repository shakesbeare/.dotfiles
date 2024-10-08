{ config, pkgs, system, ... }: 
{
    programs.alacritty.enable = true;
    home.sessionVariables = {
        TERMINAL = "alacritty";
    };

    home.file = {
        ".config/alacritty/alacritty.toml".source = (pkgs.formats.toml { }).generate "alacritty-config" {
            live_config_reload = true;
            shell.program = "zsh";
            env = {
                TERM = "alacritty";
            };

            window = {
                startup_mode = "Maximized";
                decorations = if system == "aarch64-darwin" then "Buttonless" else "None";
                dynamic_title = true;
                opacity = 0.80;
                blur = false;
                padding = { x = 5; y = 5; };
                option_as_alt = "OnlyLeft";
            };


            font = {
                # normal = { family = "UbuntuMono Nerd Font" }
                normal = { family = "Berkeley Mono"; style = "Regular"; };
                # bold = { family = "Consolas", style = "Bold" }
                size = if system == "aarch64-darwin" then 15 else 10;
                offset = { x = 0; y = 0; };
            };

            cursor = {
                style.blinking = "Always";
                blink_interval = 500;
                blink_timeout = 0;
            };

            colors = {
                draw_bold_text_with_bright_colors = true;
                cursor = { text = "#D3D3D3"; cursor = "#D3D3D3"; };
                primary.background = "#0C0C0C";
            };

            colors.normal = {
                black = "#000000";
                white = "#CCCCCC";
                red = "#ff8080";
                yellow = "#f4ff80";
                green = "#80ff80";
                cyan = "#b3e5ff";
                blue = "#80c3ff";
                magenta = "#d580ff";
            };

            colors.bright = {
                black = "#767676";
                red = "#E74856";
                green = "#16C60C";
                yellow = "#F9F1A5";
                blue = "#3B78FF";
                magenta = "#B4009E";
                cyan = "#61D6D6";
                white = "#F2F2F2";
            };

            keyboard = {
                bindings = [
                    {
                        key = "F";
                        mods = "Command";
                        action = "ToggleSimpleFullscreen";
                    }
                ];
            };
        };
    };
}
