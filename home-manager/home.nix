{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
  	pkgs.cowsay;
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
}
