{ config, pkgs, ... }:
{
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
}
