{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.haskellPackages.ghcup
  ];

  home.file = {
    ".config/rustfmt/rustfmt.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/cargo/rustfmt.toml";
  };
}
