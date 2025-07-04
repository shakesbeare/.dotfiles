{
  config,
  pkgs,
  lib,
  ...
}: {
  # DANGER ZONE {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  # }

  imports = [
    ./modules/alacritty.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
    ./modules/scripts.nix
    ./modules/btop.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/programming.nix
    ./modules/discord.nix
    ./modules/yabai.nix
    ./modules/shake.nix
    ./modules/fonts.nix
    ./modules/lf.nix
  ];

  home.sessionVariables = {
    SYSTEM = "aarch64-darwin";
  };

  programs.sketchybar = {
    enable = true;
  };
}
