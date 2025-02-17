{
  config,
  pkgs,
  inputs,
  system,
  ...
}: {
  fonts.fontconfig.enable = true;

  home.file = {
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ghostty/";
      text =
        builtins.readFile ../../ghostty/config
        + (
          if system == "aarch64-darwin"
          then ''font-size = 15''
          else ''font-size = 12''
        );
    };
  };
}
