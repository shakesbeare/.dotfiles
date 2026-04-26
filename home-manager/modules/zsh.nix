{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.fastfetch
    pkgs.onefetch
    pkgs.eza
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initContent = builtins.readFile ../../zsh/.zshrc;
    envExtra = builtins.readFile ../../zsh/.zshenv;
  };
  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.btop.enable = true;

  # home.file = {
  #   ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/zsh/.zshrc";
  # };
}
