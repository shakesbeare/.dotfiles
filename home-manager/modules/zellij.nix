{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.zellij
  ];

  home.file = {
    ".config/zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/zellij/config.kdl";
    ".config/zellij/layouts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/zellij/layouts";
  };
}
