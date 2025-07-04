{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  imports = [
    ./modules/macos-homebrew.nix
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.nixd
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  nix.enable = true;
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
  };

  services.sketchybar = {
    enable = true;
  };

  services.skhd.enable = true;

  # add as many settings as possible here
  # to avoid needing to redo them later
  system = {
    primaryUser = "bmoffett";
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "bottom";
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf"; # current folder
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  users.users.bmoffett = {
    home = "/Users/bmoffett";
  };
}
