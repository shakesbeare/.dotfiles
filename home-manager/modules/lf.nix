{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.lf
  ];

  home.file = {
    ".config/lf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/lf";
  };
}
