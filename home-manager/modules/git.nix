{ config, pkgs, ... }:
{
    programs.git = {
        enable = true;
        userName = "Berint Moffett";
        userEmail = "berint.moffett@gmail.com";
        extraConfig = {
            init.defaultBranchName = "main";
            pull.ff = "only"
        };
    };
}
