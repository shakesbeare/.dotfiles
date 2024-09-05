{ config, pkgs, ... }: 
{
    programs.alacritty.enable = true;
    home.sessionVariables = {
        TERMINAL = "alacritty";
    };

    home.file = {
        "foo.toml".source = (pkgs.formats.toml { }).generate "bar.toml" {
            settings = {
                test = true;
            };
        };
    };
}
