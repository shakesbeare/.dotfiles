#!/bin/bash
set -e
pushd ~/dotfiles/nixos/
find . | grep "\.nix" | xargs git diff
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
