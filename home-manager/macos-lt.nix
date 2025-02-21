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
    ./modules/ghostty.nix
  ];

  home.sessionVariables = {
    SYSTEM = "aarch64-darwin";
  };

    home.activation = if pkgs.stdenv.isDarwin then 
    {
        brewInstallFirefox = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /opt/homebrew/bin/brew install firefox 
        '';
        brewInstallDropbox = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /opt/homebrew/bin/brew install dropbox
        '';
        brewInstallMacsFanControl = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /opt/homebrew/bin/brew install macs-fan-control
        '';
        brewInstallSpotify = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /opt/homebrew/bin/brew install spotify
        '';

        brewInstallZig = lib.hm.dag.entryAfter ["writeBoundary"] ''
        /opt/homebrew/bin/brew install zig
        '';
    } else {};
}
