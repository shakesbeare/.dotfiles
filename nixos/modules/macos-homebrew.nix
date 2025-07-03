{
  config,
  pkgs,
  ...
}: {
  homebrew = {
    enable = true;
    global = {autoUpdate = false;};
    onActivation = {
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    casks = [
      "firefox"
      "google-chrome"

      "dropbox"
      "macs-fan-control"

      "alacritty"
      "discord"
      "obsidian"
      "parsec" # remote desktop
      "steam"
      "ukelele" # edit keyboard layouts
      "zoom"
      "focusrite-control"
      "skim"
      "microsoft-word"
    ];
    taps = [
      "homebrew/core"
      "homebrew/bundle"
      "homebrew/services"
    ];
  };
}
