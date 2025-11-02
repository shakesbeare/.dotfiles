# all graphical applications should be installed with homebrew
# terminal only apps or services should be installed elsewhere
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

    # TODO: possibly reorganize these to better modularize
    # some macos nix setup might not want focusrite-control, for example
    # not necessary, for now

    taps = [
      "homebrew/core"
      "homebrew/bundle"
      "homebrew/services"
    ];
    brews = [
      "marp-cli" # markdown to pptx
    ];
    casks = [
      "firefox"
      "google-chrome"

      "dropbox"
      "macs-fan-control"
      "espanso"

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
      # "virtualbox"

      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
    ];
  };
}
