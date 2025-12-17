{ config, pkgs, ... }:

{
  imports = [
    ./gaming.nix
    ./git.nix
    ./packages.nix
    ./vscode.nix
  ];
}
