{ config, pkgs, ... }:
{
    programs.cava = {
        enable = true;
        settings.input.method = "pipewire";
    };
}
