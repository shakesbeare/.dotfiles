{ config, pkgs, inputs, ... }:
{
    programs._1password.enable = true;
    programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "bmoffett" ];
    };

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}"];
}
