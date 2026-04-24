{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.rustup
    (pkgs.python3.withPackages (ps: with ps; [requests]))
    pkgs.cmake
    pkgs.cargo-expand
    pkgs.nodejs
    pkgs.binaryen
    pkgs.gh
    pkgs.zip
    pkgs.unzip
    pkgs.just
    pkgs.uv
  ];

  programs = {
    bacon.enable = true;
  };

  home.file = {
    ".config/rustfmt/rustfmt.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/cargo/rustfmt.toml";
  };
}
