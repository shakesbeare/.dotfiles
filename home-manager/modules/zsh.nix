{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.fastfetch
    pkgs.onefetch
  ];

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../../zsh/.zshrc;
    envExtra = builtins.readFile ../../zsh/.zshenv;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.htop.enable = true;
  programs.ripgrep.enable = true;

  # home.file = {
  #   ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/zsh/.zshrc";
  # };
}
