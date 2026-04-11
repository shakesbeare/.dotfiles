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
    ".config/zellij/plugins/zellij-sessionize.wasm".source = pkgs.fetchurl {
      url = "https://github.com/laperlej/zellij-sessionizer/releases/download/v0.5.0/zellij-sessionizer.wasm";
      sha256 = "0nx01gmf9jaivw22dffdy8nj1v840mgdkn0gkbwq2kp74g042664";
    };
  };
}
