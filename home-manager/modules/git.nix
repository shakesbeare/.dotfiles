{...}: {
  programs.git = {
    enable = true;
    userName = "Berint Moffett";
    userEmail = "berint.moffett@gmail.com";
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      hist = "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(red)%s %C(bold red){{%an}}%C(reset) %C(blue)%d%C(reset)' --graph --date=short";
      graph = "log --all --graph --decorate --pretty=format:'%C(#005f87)%h%Creset :%C(#d75f00)%d%Creset %C(#005f87)%an%Creset %C(#008700)%cd (%cr)%n%s%n' --date=short";
    };
    extraConfig = {
      init.defaultBranchName = "main";
      core.editor = "$(which nvim)";
      merge = {
        tool = "nvim";
        cmd = "/Users/bmoffett/.local/share/bob/nvim-bin/nvim \\\"$MERGED\\\" -c \":Gvdiffsplit!\"";
      };
    };
  };
}
