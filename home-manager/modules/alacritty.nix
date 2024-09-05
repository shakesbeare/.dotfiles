{ config, pkgs, ... }: 
{
    programs.alacritty.enable = true;
    home.sessionVariables = {
        TERMINAL = "alacritty";
    };

    home.file = {
        "test.toml".source = (pkgs.formats.toml { }).generate "test.toml" {
            settings = {
                test = true;
            };
        };
    };
}
