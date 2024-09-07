{ config, pkgs, ... }:
{
    programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
            obs-background-removal
            obs-pipewire-audio-capture
        ];
    };
}
