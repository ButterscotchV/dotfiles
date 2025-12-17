{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./packages.nix
    ./vscode.nix
  ];
}
